<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\UserService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Laravel\Passport\Token;

class UserController extends Controller
{
    /**
     * @var UserService
     */
    protected $userService;

    /**
     * UserController constructor.
     * @param UserService $userService
     */
    public function __construct(UserService $userService)
    {

        $this->middleware('acl:super-admin');
        $this->userService = $userService;

    }


    /**
     * @return JsonResponse
     */
    public function index(Request $request)
    {

        return $this->userService->paginateData($request);

    }

    /**
     * @return void
     */
    public function create()
    {

        /*$roles = Role::pluck('name', 'name')->all();

        return view('users.create', compact('roles'));*/

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {

        return $this->userService->createItem($request);

    }


    /**
     * @param $id
     * @return mixed
     */
    public function show($id)
    {

        return $this->userService->getById($id);

    }

    /**
     * @param $id
     * @return void
     */
    public function edit($id)
    {

        /*$users = $this->userService->getById($id);
        $roles = Role::pluck('name','name')->all();
        $userRole = $users->roles->pluck('name','name')->all();

        return view('users.edit',compact('users','roles','userRole'));*/

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function update(Request $request)
    {

        return $this->userService->updateItem($request);

    }


    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function destroy(Request $request)
    {

        return  $this->userService->deleteItem($request->id);

    }

    public function changePassword(Request $request)
    {
        return $this->userService->updatePassword($request);

       // return redirect()->route('admin.auth.user.index')->withFlashSuccess(__('alerts.backend.users.updated_password'));
    }

    public function exportUsers(){
        return "Hi";
    }
}
