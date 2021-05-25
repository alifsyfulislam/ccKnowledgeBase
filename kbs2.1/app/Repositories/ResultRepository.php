<?php


namespace App\Repositories;
use DB;

use App\Models\Result;

class ResultRepository
{
    
    public function getWithPagination() {

        // return Result::with('user')->orderBY('created_at','DESC')->paginate(20);
        return Result::with('user')->select('user_id')->groupby('user_id')->orderby('created_at','DESC')->paginate(20);

    }

    public function UserQuizList($request) {
        return Result::select('id','user_id','quiz_id',DB::raw("MAX(attempt) as attempt"))->with('user','quiz')->where('user_id',$request->userId)->groupby('quiz_id')->orderby('created_at','DESC')->paginate(20);
    }

    public function UserQuizResultList($request) {
        return Result::with('user','quiz')->where(['user_id'=>$request->userId,'quiz_id'=>$request->quizId])
        ->groupby('attempt')->orderby('id','DESC')->paginate(20);
    }


    public function getResultData($quizResult) {
        return Result::with('user','quiz','question')->where(['user_id'=>$quizResult->user_id,'quiz_id'=>$quizResult->quiz_id,'attempt'=>$quizResult->attempt])
        ->get();
    }
    

    public function create(array $data){

        $dataObj =  new Result();
        $dataObj->id = $data['id'];
        $dataObj->user_id = $data['user_id'];
        $dataObj->quiz_id = $data['quiz_id'];
        $dataObj->question_id = $data['question_id'];
        $dataObj->answer = $data['answer'];
        $dataObj->attempt = $data['attempt'];
        return $dataObj->save();
    }

    public function checkAttempt($userId, $quizId) {
        $attemptDetails = Result::where(['user_id'=>$userId, 'quiz_id'=>$quizId])->orderby('id','DESC')->first();
        return $attemptDetails;
    }
    public function delete($id) {
        return Result::find($id)->delete();
    }

}