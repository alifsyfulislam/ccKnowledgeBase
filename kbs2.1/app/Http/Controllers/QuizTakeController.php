<?php

namespace App\Http\Controllers;

use App\Models\QuizFormField;

class QuizTakeController extends Controller
{
    public function index($id){
        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200'),
            'quiz_form_field_list' => $this->getFormListUsingForm($id)
        ]);
    }


    public function getFormListUsingForm($id)
    {

        return QuizFormField::where('quiz_form_id', $id)->inRandomOrder()->paginate(1);

    }



}
