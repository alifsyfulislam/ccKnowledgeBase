<?php

namespace App\Http\Controllers;


use App\Services\CrudHistoryService;
use Auth;

class CrudHistoryController extends Controller
{
    //
    protected $crudHistoryService;

    public function __construct(CrudHistoryService $crudHistoryService)
    {

        //$this->middleware("auth");
        $this->crudHistoryService = $crudHistoryService;

    }




    public function index($post_id)
    {

        if(Auth::user()) {

            return $this->crudHistoryService->paginateData($post_id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }
}
