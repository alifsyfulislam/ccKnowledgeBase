<?php


namespace App\Services;


use App\Repositories\ResultRepository;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class ResultService
{

    protected $resultRepository;

    public function __construct(ResultRepository $resultRepository)
    {
        $this->resultRepository = $resultRepository;
    }

    public function paginateData(){

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'notification_list' => $this->resultRepository->getWithPagination()

        ]);
    }

    public function createItem($request){
        $validator = Validator::make($request->all(),[

            'user_id' => "required",
            'quiz_id' => "required",

        ]);

        if($validator->fails()) {
            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);
        }

        $input = [];
        $quesAndAns = json_decode($request->ques_and_ans,true);

        DB::beginTransaction();

        try {
            $attempDetails =  $this->resultRepository->checkAttempt($request->user_id, $request->quiz_id);
            if($attempDetails) {
              $attempCount =  $attempDetails->attempt+1;
            } else {
                $attempCount = 1;
            }
            foreach($quesAndAns as $key=>$value) {
                $input['id'] = time().rand(1000,9000);
                $input['user_id'] = $request->user_id;
                $input['quiz_id'] = $request->quiz_id;
                $input['question_id'] = $key;
                $input['answer'] = $value;
                $input['attempt'] = $attempCount;
                $this->resultRepository->create($input);
            }
            // $this->resultRepository->create($input);
            return $attempCount;

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
            'messages'=>config('status.status_code.200'),
        ]);
    }

    
    public function deleteItem($id){

        DB::beginTransaction();

        try {

            $this->resultRepository->delete($id);

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
            'messages'    => "Comment Deleted Successfully"

        ]);
    }
}