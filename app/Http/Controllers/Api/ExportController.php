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
        $userData =  User::with(['roles' => function($q) {$q->select('id', 'name');}, 'media'])->get();

      //  'name' => $userData->name
        //dd($userData->roles[0]->name);

        return Excel::download(new UsersExport($userData), 'users.xlsx');

      //  return (new UsersExport($data['users']))->download('users'.date('Y-m-d').'.xlsx');
    }
}
