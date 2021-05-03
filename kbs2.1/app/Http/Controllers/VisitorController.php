<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\JsonResponse;
use App\Repositories\UserRepository;
use Auth;

class VisitorController extends Controller
{
    protected $userRepository;


    /**
     * AuthController constructor.
     * @param UserRepository $userRepository
     */
    public function __construct(UserRepository $userRepository)
    {

        $this->userRepository = $userRepository;

    }

    public function logout(Request $request) {
        $user = User::find($request->id);
        if ($user) {
            $user->tokens()->delete();
            return response()->json([
                'status_code'   => 200,
                'status'        => config('status.status_code.200'),
                'message'       => 'Logged out successfully!'
            ]);
        }else{
            return response()->json([
                'status_code'   => 200,
                'status'        => config('status.status_code.200'),
                'message'       => "Could not logout!"
            ]);
        }
    }

    public function index(Request $request){
//        return $request->all();

        $validator = Validator::make($request->all(), [

            'username'=>'required',
            'password' => 'required'

        ]);

        if ($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->messages()->all()
            ]);

        }
        $fieldType = filter_var($request->username, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

        if(Auth::attempt(array($fieldType => $request->username, 'password' => $request->password)) ) {
            $user = Auth::user();

            $userInfo =  User::with([ 'media', 'roles' => function($query){$query->select('id', 'name', 'slug');}])->findOrFail($user->id);

            $success['status_code'] = 200;
            $success['messages']    = config('status.status_code.200');
            $success['token']       = $user->createToken('Knowledge Base')->accessToken;
            $success['user_info']   = $userInfo;

            if (Auth::user()){
                return response()->json($success);
            }
        }
    }
}
