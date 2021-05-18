<?php


namespace App\Repositories;


use App\Models\Result;

class ResultRepository
{
    
    public function getWithPagination() {

        return Result::with('user')->orderBY('created_at','DESC')->paginate(20);

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