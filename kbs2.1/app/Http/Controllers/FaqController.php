<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\FaqService;
use Auth;

class FaqController extends Controller
{
    protected $faqService;

    public function __construct(FaqService $faqService)
    {

        $this->faqService = $faqService;

    }

    public function index(Request $request)
    {
        
        if(Auth::user()->can('faq-list')) {

            return $this->faqService->paginateData($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }

    public function faqList(Request $request)
    {

        return $this->faqService->getFaqList($request);

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        
        if(Auth::user()->can('faq-create')) {

            return $this->faqService->createItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);
        }

    }

    
    public function show($id)
    {

        if(Auth::user()->can('faq-list')) {

            return $this->faqService->getById($id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }

    public function update(Request $request)
    {
        
        if(Auth::user()->can('faq-edit')) {

            return $this->faqService->updateItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }


    public function destroy(Request $request)
    {
        
        if(Auth::user()->can('faq-delete')) {

            return  $this->faqService->deleteItem($request->id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }
}
