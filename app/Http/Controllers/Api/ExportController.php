<?php

namespace App\Http\Controllers\Api;

use App\Exports\UsersExport;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Maatwebsite\Excel\Facades\Excel;

class ExportController extends Controller
{
    public function exportUsers(){
        $userData =  User::with(['roles' => function($q) {$q->select('id', 'name');}, 'media'])
            ->get()->map(function ($userData){
                return [
                    'id'          => $userData->id,
                    'username'    => $userData->title,
                    'first_name'  => $userData->first_name,
                    'last_name'   => $userData->last_name,
                    'email'       => $userData->email,
                    'role_name'   => $userData->roles ? $userData->roles[0]->name : null,
                    'created_at'  => $userData->created_at,
                    'updated_at'  => $userData->updated_at,
                ];
            });
       // dd($userData);

        return Excel::download(new UsersExport($userData), 'users.xlsx');

    }
}
