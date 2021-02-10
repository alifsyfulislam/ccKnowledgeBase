<?php

namespace App\Http\Controllers;

use App\Services\QuizFormFieldService;
use Illuminate\Http\Request;

class QuizTakeController extends Controller
{
    private $quizFormFieldService;

    public function __construct(QuizFormFieldService $quizFormFieldService)
    {
        // $this->middleware('auth');
        $this->quizFormFieldService = $quizFormFieldService;

    }

    public function getQuizFieldListFromQuizForm($id)
    {

        return $this->quizFormFieldService->getFieldUsingForm($id);

    }
}
