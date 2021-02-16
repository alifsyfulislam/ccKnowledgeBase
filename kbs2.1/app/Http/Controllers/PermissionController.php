<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\PermissionService;
use Auth;

class PermissionController extends Controller
{
    /**
     * @var PermissionService
     */
    protected $permissionService;


    /**
     * PermissionController constructor.
     * @param PermissionService $permissionService
     */
    public function __construct(PermissionService $permissionService)
    {
        
        $this->permissionService = $permissionService;

    }


    /**
     * @return mixed
     */
    public function index()
    {
        
        if(Auth::user()->can('permission-list')) {

            return $this->permissionService->paginateData();

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {
        
        if(Auth::user()->can('permission-create')) {

            return $this->permissionService->createItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }


    /**
     * @param $id
     * @return mixed
     */
    public function show($id)
    {

        if(Auth::user()->can('permission-list')) {

            return $this->permissionService->getById($id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {

        if(Auth::user()->can('permission-edit')) {

            return $this->permissionService->updateItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function destroy(Request $request)
    {

        if(Auth::user()->can('permission-delete')) {

            return $this->permissionService->deleteItem($request->id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }
}
