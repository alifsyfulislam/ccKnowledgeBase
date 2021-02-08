<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\UserRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;
use Auth;

class AuthController extends Controller
{

    /**
    * @var UserRepository
    */

    protected $userRepository;


    /**
     * AuthController constructor.
     * @param UserRepository $userRepository
     */
    public function __construct(UserRepository $userRepository)
    {

        $this->userRepository = $userRepository;

    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request)
    {


        $input = $request->all();

        $validator = Validator::make($request->all(), [

            'username'=>'required',
            'password' => 'required'

        ]);

        if ($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->messages()->all()
            ]);

        } else {

            $fieldType = filter_var($request->username, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

            if(Auth::attempt(array($fieldType => $input['username'], 'password' => $input['password'])) )
            {
                $user = Auth::user();

                $userInfo = $this->userRepository->get($user->id);

                $success['status_code'] = 200;
                $success['messages']    = config('status.status_code.200');
                $success['token']       = $user->createToken('Knowledge Base')->accessToken;
                $success['user_info']   = $userInfo;

                return response()->json($success);

            } else {
                $success['status_code'] = 451;
                $success['messages'] = config('status.status_code.451');
                return response()->json($success);
            }

        }

    }

    public function logout(Request $request) {

        if ($request->user()->token()->revoke()){
            return response()->json([
                'status_code'   => 200,
                'status'        => config('status.status_code.200'),
                'message'       => 'Logged out successfully!'
            ]);

        } else{
            return response()->json([
                'status_code'   => 200,
                'status'        => config('status.status_code.200'),
                'message'       => "Could not logout!"
            ]);
        }
    }
}
