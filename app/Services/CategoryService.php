<?php


namespace App\Services;


use App\Repositories\CategoryRepository;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

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
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAll()
    {

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_list'=>$this->categoryRepository->all()]);
    }


    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getById($id)
    {

        if($this->categoryRepository->get($id))
            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_info'=>$this->categoryRepository->get($id)]);

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_info'=>"Data not found"]);

    }


    /**
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function createItem($request)
    {

        $validator = Validator::make($request->all(),[

            'name' => 'required',
            'parent_id' => 'required',


        ]);

        if($validator->fails()) {

            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);

        }

        $input = $request->all();
        $input['id'] = time().rand(1000,9000);


        DB::beginTransaction();

        try {


            $this->categoryRepository->create($input);



        } catch (Exception $e) {

            DB::rollBack();
            Log::info($e->getMessage());

            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }


    /**
     * @param $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateItem($request)
    {

        $validator = Validator::make($request->all(),[

            'name' => 'required',
            'parent_id' => 'required',

        ]);

        if($validator->fails()) {

            return response()->json(['status_code' => '400', 'messages'=>config('status.status_code.400'), 'error' =>  $validator->errors()->first()]);

        }

        DB::beginTransaction();

        try {

            $this->categoryRepository->update(['name' => $request->input('title'),
                                                'parent_id' => $request->input('parent_id') ], $request->id);
            $category = $this->categoryRepository->get($request->id);
            // $category->syncPermissions($request->input('permission'));

        } catch (Exception $e) {

            DB::rollBack();
            Log::info($e->getMessage());

            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }


    /**
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function deleteItem($id)
    {
        DB::beginTransaction();

        try {

            $this->categoryRepository->delete($id);

        } catch (\Exception $e) {

            DB::rollBack();

            Log::info($e->getMessage());
            //return $this->error($e->getMessage(), $e->getCode());
            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        //return $this->success(config('status.status_code.200'), "Category Deleted" );


    }


    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function paginateData()
    {

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'category_list'=>$this->categoryRepository->getWithPagination()]);

    }

}
