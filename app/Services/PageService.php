<?php


namespace App\Services;


use App\Helpers\Helper;
use App\Repositories\QuizRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class PageService
{

    /**
     * @var QuizRepository
     */
    protected $pageRepository;


    /**
     * QuizFormService constructor.
     * @param QuizRepository $pageRepository
     */
    public function __construct(QuizRepository $pageRepository)
    {

        $this->pageRepository = $pageRepository;

    }


    /**
     * @return JsonResponse
     */
    public function getAll()
    {
        return response()->json([
            'status_code' => 200,
            'messages'=>config('status.status_code.200'),
            'quiz_form_list'=>$this->pageRepository->all()
        ]);
    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function getById($id)
    {

        if($this->pageRepository->get($id))
            return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200'), 'quiz_info'=>$this->pageRepository->get($id)]);

        return response()->json(['status_code' => 302, 'messages'=>config('status.status_code.302'), 'quiz_info'=>"Data not found"]);

    }


    /**
     * @param $request
     * @return JsonResponse
     */
    public function createItem($request)
    {
        $validator = Validator::make($request->all(),[
            'title' => 'required',
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => '400',
                'messages'=>config('status.status_code.400'),
                'error' =>  $validator->errors()->first()
            ]);

        }

        $input = $request->all();
        $input['slug'] = Helper::slugify($input['name']);
        $input['id'] = time().rand(1000,9000);

        $this->pageRepository->create($input);

        return response()->json(['status_code' => 201, 'messages'=>config('status.status_code.201')]);
    }


    /**
     * @param $request
     * @param $id
     * @return JsonResponse
     */
    public function updateItem($request)
    {

        $validator = Validator::make($request->all(),[

            // 'article_id' => 'required',
            'quiz_form_id' => 'required',
            'name' => 'required',
            'duration' => 'required',
            'total_marks' => 'required',
            'number_of_questions' => 'required',
            'status' => 'required',

        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => '400',
                'messages'=>config('status.status_code.400'),
                'error' =>  $validator->errors()->first()]);
        }

        DB::beginTransaction();

        try {

            $input = $request->all();
            $input['slug'] = Helper::slugify($input['name']);

            $this->pageRepository->update($input, $request->id);

        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function deleteItem($id)
    {

        DB::beginTransaction();

        try {

            $this->pageRepository->delete($id);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json(['status_code' => '424', 'messages'=>config('status.status_code.424'), 'error' => $e->getMessage()]);
        }

        DB::commit();

        return response()->json(['status_code' => 200, 'messages'=>config('status.status_code.200')]);

    }

}
