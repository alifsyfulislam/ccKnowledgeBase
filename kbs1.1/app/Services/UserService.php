<?php

namespace App\Services;

use App\Helpers\Helper;
use App\Repositories\UserRepository;
use Exception;
use http\Env\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;


class UserService
{

    /**
     * @var UserRepository
     */
    protected $userRepository;


    /**
     * UserService constructor.
     * @param UserRepository $userRepository
     */
    public function __construct(UserRepository $userRepository)
    {

        $this->userRepository = $userRepository;

    }


    /**
     * @return JsonResponse
     */
    public function getAll()
    {

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200'),
            'user_list'=>$this->userRepository->all()
        ]);
    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function getById($id)
    {

        if($this->userRepository->get($id))
            return response()->json([
                'status_code' => 200,
                'messages'=>config('status.status_code.200'),
                'user_info'=>$this->userRepository->get($id)
            ]);

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200'),
            'user_info'=>"Data not found"
        ]);
    }

    public function getUserNameExist($request){
        if (!empty($request->id)){
            $validator = Validator::make($request->all(),[
                'username'   => "required|string|max:50|min:3|unique:users,username,$request->id,id",
            ]);
        }
        else{
            $validator = Validator::make($request->all(),[
                'username'   => 'unique:users',
            ]);
        }


        if($validator->fails()) {
            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'error'      => $validator->errors()->first()
            ]);
        }
    }

    public function getUserEmailExist($request){
        if (!empty($request->id)){
            $validator = Validator::make($request->all(),[
                'email'      => "required|unique:users,email,$request->id,id",
            ]);
        }else{
            $validator = Validator::make($request->all(),[
                'email'   => 'unique:users',
            ]);
        }

        if($validator->fails()) {
            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'error'      => $validator->errors()->first()
            ]);
        }
    }



    /**
     * @param $request
     * @return JsonResponse
     */
    public function createItem($request)
    {

        $validator = Validator::make($request->all(),[

            'first_name' => 'required|string|min:3|max:100',
            'last_name'  => 'required|string|min:3|max:100',
            'username'   => 'required|string|max:50|min:3|unique:users',
            'email'      => 'required|email|max:60|unique:users',
            'password'   => 'required|same:confirm_password',
            'roles'      => 'required'

        ]);

        if($validator->fails()) {

           return response()->json([
               'status_code' => 400,
               'messages'    => config('status.status_code.400'),
               'errors'      => $validator->errors()->all()
           ]);

        }

        if(isset($request->image_file)) {

            $thumbFile = Helper::base64ProfileImageThumbUpload("avatar", $request->image_file);

        } else {

            $thumbFile = url('/').'/media/avatar/placeholder.png';
        }


        $input = $request->all();
        $input['id'] = time().rand(1000,9000);
        $input['password'] = Hash::make($request->password);

        DB::beginTransaction();

        try {

            $this->userRepository->create($input);
            $user = $this->getItemById($input['id']);

            $user->roles()->attach($request->input('roles'));

            $user->media()->create([

                'url' => $thumbFile

            ]);

        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'=>config('status.status_code.424'),
                'error' => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 201,
            'messages'=>config('status.status_code.201')
        ]);


    }

    /**
     * @param $request
     * @return JsonResponse
     */
    public function updateItem($request)
    {
        $validator = Validator::make($request->all(),[
            'first_name' => 'required|string|min:3|max:100',
            'last_name'  => 'required|string|min:3|max:100',
            'username'   => "required|string|max:50|min:3|unique:users,username,$request->id,id",
            'email'      => "required|unique:users,email,$request->id,id",
            'roles'      => 'required'
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages' => config('status.status_code.400'),
                'errors' =>  $validator->errors()->all()
            ]);

        }

        $input = $request->all();

        $input['slug']   = Helper::slugify($request->first_name.$request->last_name) ;
        $input['status'] = $request->status ?? 1;

        if(!empty($input['password'])) {

            $input['password'] = Hash::make($input['password']);

        } else {

            $input = Arr::except($input,array('password'));

        }

        DB::beginTransaction();

        try {

            $this->userRepository->update($input, $input['id']);
            $user = $this->getItemById($input['id']);

            DB::table('users_roles')->where('user_id', $input['id'])->delete();
            DB::table('users_permissions')->where('user_id', $input['id'])->delete();

            $user->roles()->attach($request->input('roles'));


        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'=>config('status.status_code.424'),
                'error' => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200')
        ]);

    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function deleteItem($id)
    {
        DB::beginTransaction();

        try {

            $this->userRepository->delete($id);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json(['status_code' => 424, 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);
    }

    public function updatePassword($request)
    {
        $validator = Validator::make($request->all(),[
            'password' => 'required|between:8,32|same:confirm_password|regex:/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*\d)(?=.*[$%&_+-.@#]).+$/',

        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $input['password'] = Hash::make($request->password);

        DB::beginTransaction();

        try {

            $this->userRepository->update($input, $request->id);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code'   => 424,
                'messages'      => config('status.status_code.424'),
                'error'         => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);
    }


    /**
     * @return JsonResponse
     */
    public function paginateData($request)
    {

        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200'),
            'user_list'=>$this->userRepository->getWithPagination($request)
        ]);

    }


    /**
     * @param $id
     * @return mixed
     */
    public function getItemById($id)
    {

        return $this->userRepository->getUser($id);
    }

}
