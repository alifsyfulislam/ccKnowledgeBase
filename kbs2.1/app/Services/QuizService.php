<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Repositories\QuizRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Exception;

class QuizService
{
    /**
     * @var QuizRepository
     */
    protected $quizRepository;


    /**
     * QuizFormService constructor.
     * @param QuizRepository $quizRepository
     */
    public function __construct(QuizRepository $quizRepository)
    {

        $this->quizRepository = $quizRepository;

    }


    /**
     * @return JsonResponse
     */
    public function getAll()
    {
        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200'),
            'quiz_form_list' => $this->quizRepository->all()
        ]);
    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function getById($id)
    {

        if($this->quizRepository->get($id))
            return response()->json([
                'status_code' => 200,
                'messages'    => config('status.status_code.200'),
                'quiz_info'   => $this->quizRepository->get($id)
            ]);

        return response()->json([
            'status_code' => 302,
            'messages'  => config('status.status_code.302'),
            'quiz_info' => "Data not found"
        ]);

    }


    /**
     * @param $request
     * @return JsonResponse
     */
    public function createItem($request)
    {
        $validator = Validator::make($request->all(),[
            'article_id' => 'required',
            'quiz_form_id' => 'required',
            'name' => 'required|unique:quizzes,name',
            'duration' => 'required',
            'total_marks' => 'required',
            'number_of_questions' => 'required',
            'status' => 'required',
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'       => $validator->errors()->all()
            ]);
        }

        $input = $request->all();
        $input['slug'] = Helper::slugify($input['name']);
        $input['id']   = time().rand(1000,9000);

//        return  $input['article_id'];
        $selectedArticleID = array();


        foreach ($input['article_id'] as $articleID){
//            $articleID.implode(',','')
            if ($articleID["id"] != ''){
                array_push($selectedArticleID,$articleID['id'].'/'.$articleID['slug']);

            }


        }

        $list_article_id = join(",",$selectedArticleID);

//        return $list_article_id;






        $this->quizRepository->create($input,$list_article_id);

        return response()->json([
            'status_code' => 201,
            'messages' => config('status.status_code.201')
        ]);
    }


    /**
     * @param $request
     * @param $id
     * @return JsonResponse
     */
    public function updateItem($request)
    {

        $validator = Validator::make($request->all(),[
            'quiz_form_id' => 'required',
            'article_id' => 'required',
            'name' => 'required',
            'duration' => 'required',
            'total_marks' => 'required',
            'number_of_questions' => 'required',
            'status' => 'required',

        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'=> config('status.status_code.400'),
                'errors' => $validator->errors()->all()
            ]);
        }

        DB::beginTransaction();

        try {

            // $result_array =$request->role_id; 
            // $roleIds =  implode(',',$result_array);
            $input = $request->all();
            $input['role_id'] = implode(',', $input['role_id']);
            $input['slug'] = Helper::slugify($input['name']);

            $selectedArticleID = array();

            foreach ($input['article_id'] as $articleID){
                if ($articleID["id"] != ''){
                    array_push($selectedArticleID,$articleID['id'].'/'.$articleID['slug']);
                }


            }

            $list_article_id = join(",",$selectedArticleID);

            $this->quizRepository->update($input, $request->id, $list_article_id);

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

            $this->quizRepository->delete($id);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages' => config('status.status_code.424'),
                'error' => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages' => config('status.status_code.200')
        ]);

    }


    /**
     * @return JsonResponse
     */
    public function paginateData($request)
    {
        return response()->json([
            'status_code' => 200,
            'messages' => config('status.status_code.200'),
            'quiz_list' => $this->quizRepository->getWithPagination($request)
        ]);

    }
}
