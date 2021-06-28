<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Models\Category;
use App\Models\Media;
use App\Repositories\CategoryRepository;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Auth;

class CategoryService
{

    /**
     * @var CategoryRepository
     */
    protected $categoryRepository;


    /**
     * CategoryService constructor.
     * @param CategoryRepository $categoryRepository
     */
    public function __construct(CategoryRepository $categoryRepository)
    {
        $this->categoryRepository = $categoryRepository;
    }


    /**
     * @return JsonResponse
     */
    public function getAll()
    {

        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200'),
            'category_list' => $this->categoryRepository->all()
        ]);
    }

    public function getLatestCategory(){
        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200'),
            'category_info' => $this->categoryRepository->latestCategory()
        ]);
    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function getById($id)
    {

        if($this->categoryRepository->get($id))
            return response()->json([
                'status_code' => 200,
                'messages'    => config('status.status_code.200'),
                'category_info' => $this->categoryRepository->get($id)
            ]);

        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200'),
            'category_info' => "Data not found"
        ]);

    }


    /**
     * @param $request
     * @return JsonResponse
     */

    public function getCategoryNameExist($request){
        if (!empty($request->id)){
            $validator = Validator::make($request->all(),[
                'name' => "required|min:3|max:100|unique:categories,name,$request->id,id",
            ]);
        }
        else{
            $validator = Validator::make($request->all(),[
                'name' => "required|min:3|max:100|unique:categories,name,$request->id,id",
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


    public function createItem($request)
    {
        $validator = Validator::make($request->all(),[

            'name' => "required|min:3|max:100|unique:categories,name,$request->id,id",

            ]);

        if($validator->fails()) {
            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }



        $input = $request->all();
        $input['id'] = time().rand(1000,9000);
        $input['user_id'] = Auth::user()->id;


//        return $input['user_email'];

        DB::beginTransaction();

        try {

            $result_array = explode(",",$request->role_id);

            if (in_array('1',$result_array)){
                $this->categoryRepository->create($input);
            }else{
                array_push($result_array,1);
                $request->role_id = implode(',',$result_array);
                $this->categoryRepository->create($input);
            }

//            $this->categoryRepository->create($input);

            $category = $this->categoryRepository->get($input['id']);

            $category->history()->create([
                'user_id'           => $input['user_id'],
                'post_id'           => $input['id'],
                'operation_type'    => $request->route()->getActionMethod()
            ]);

            if($request->hasFile('logo')) {

                $logo_url  = Helper::base64PageLogoUpload("category/images", $request->logo);

                $category->media()->create([

                    'url' => $logo_url

                ]);
            }

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }


    /**
     * @param $request
     * @return JsonResponse
     */
    public function updateItem($request)
    {

        $validator = Validator::make($request->all(),[
            'name' => "required|min:3|max:100|unique:categories,name,$request->id,id",
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $input = $request->all();

        DB::beginTransaction();

        try {


            $result_array = explode(",",$input['role_id']);



            if (in_array('1', $result_array)){
                $input['role_id'] =  implode(',',$result_array);
                $this->categoryRepository->update([
                    'name' => $request->input('name'),
                    'slug' => Helper::slugify($request->input('name')),
                    'parent_id' => $request->input('parent_id') ?? 0,
                    'role_id' => $input['role_id']
                ], $request->id);
            }else{
                array_push($result_array,1);
                $input['role_id'] = implode(',',$result_array);
                $this->categoryRepository->update([
                    'name' => $request->input('name'),
                    'slug' => Helper::slugify($request->input('name')),
                    'parent_id' => $request->input('parent_id') ?? 0,
                    'role_id' => $input['role_id']
                ], $request->id);
            }



            $category = $this->categoryRepository->get($input['id']);

            $category->history()->create([
                'user_id' => Auth::user()->id,
                'post_id' => $request->id,
                'operation_type' => $request->route()->getActionMethod()
            ]);

            if($request->hasFile('logo')) {


                $media= Media::where('mediable_id', $input['id'])->first();

                if ($media){
                    $mediaName =  substr($media->url, strpos($media->url, "media") );
                    unlink(public_path().'/'.$mediaName );
                    $media->delete();
                }

                $logo_url  = Helper::base64PageLogoUpload("category/images", $request->logo);

                $category->media()->create([

                    'url' => $logo_url

                ]);
            }


        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages'    => "Category Updated Successfully"
        ]);

    }


    public function deleteItem($id)
    {
        DB::beginTransaction();

        try {

            $childCheck = Category::where('parent_id', $id)->get();

            if ($childCheck->isNotEmpty()){

                return response()->json([
                    'status_code' => 400,
                    'messages'    => config('status.status_code.400'),
                    'error'       => 'Please delete the child category first'
                ]);

            }else{
                $category = $this->categoryRepository->get($id);

                $category->history()->create([
                    'user_id' => Auth::user()->id,
                    'post_id' => $id,
                    'operation_type' => 'delete'
                ]);
                $this->categoryRepository->delete($id);
            }

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages'    => "Category Deleted Successfully"
        ]);

    }

    /**
     * @return JsonResponse
     */
    public function paginateData($request)
    {
        return response()->json([
            'status_code'   => 200,
            'messages'      => config('status.status_code.200'),
            'category_list' => $this->categoryRepository->getWithPagination($request)]);

    }


    public function categoryArticles()
    {

        return response()->json([
            'status_code'   => 200,
            'messages'      => config('status.status_code.200'),
            'category_list' => $this->categoryRepository->categoryArticles()]);

    }

    public function getCategoryListForUpdate($request)
    {

        return response()->json([
            'status_code'   => 200,
            'messages'      => config('status.status_code.200'),
            'category_list' => $this->categoryRepository->categoryListForUpdate($request)]);

    }
}
