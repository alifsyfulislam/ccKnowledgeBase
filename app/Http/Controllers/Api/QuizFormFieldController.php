<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\QuizFormField;
use App\Services\QuizFormFieldService;
use App\Services\QuizFormService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class QuizFormFieldController extends Controller
{

    /**
     * @var QuizFormFieldService
     */
    private $quizFormFieldService;


    /**
     * PermissionController constructor.
     * @param QuizFormFieldService $quizFormFieldService
     */
    public function __construct(QuizFormFieldService $quizFormFieldService)
    {
        $this->middleware('auth');
        $this->quizFormFieldService = $quizFormFieldService;

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        if(Auth::user()->can('quiz-form-list')) {

            return $this->quizFormFieldService->paginateData();

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        if(Auth::user()->can('quiz-form-create')) {

            return $this->quizFormFieldService->createItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\QuizFormField  $quizFormField
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        if(Auth::user()->can('quiz-form-list')) {

            return $this->quizFormFieldService->getById($id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\QuizFormField  $quizFormField
     * @return \Illuminate\Http\Response
     */
    public function edit(QuizFormField $quizFormField)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\QuizFormField  $quizFormField
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request)
    {
        if(Auth::user()->can('quiz-form-edit')) {

            return $this->quizFormFieldService->updateItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\QuizFormField  $quizFormField
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(Request $request)
    {
        if(Auth::user()->can('quiz-form-delete')) {

            return $this->quizFormFieldService->deleteItem($request->id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }
    }
}
