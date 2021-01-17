<?php

namespace App\Http\Controllers\Api;

use App\Exports\ArticlesExport;
use App\Exports\CategoriesExport;
use App\Exports\UsersExport;
use App\Models\Article;
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
                    'username'    => $userData->username,
                    'first_name'  => $userData->first_name,
                    'last_name'   => $userData->last_name,
                    'email'       => $userData->email,
                    'role_name'   => (count($userData->roles)>0) ?  $userData->roles[0]->name : 'N/A',
                    'created_at'  => $userData->created_at,
                    'updated_at'  => $userData->updated_at,
                ];
            });
        return Excel::download(new UsersExport($userData), 'users-'.date("d-m-y-H-i-s").'.csv');
    }

    public function exportCategories(){
        return Excel::download(new CategoriesExport(), 'categories-'.date("d-m-y-H-i-s").'.csv');
    }

<<<<<<< HEAD
    public function exportArticles(){
        $articleData = Article::with(['user'=> function($q) {$q->select('id', 'first_name','last_name');},'category'=> function($q) {$q->select('id', 'name');}])->get()->map(function ($articleData){
            return [
                'id'                        => $articleData->id,
                'en_title'                  => $articleData->en_title,
                'en_body'                   => strip_tags($articleData->en_body),
                'category_name'             => $articleData->category->name,
                'author_name'               => $articleData->user->first_name.' '.$articleData->user->last_name,
                'status'                    => $articleData->status,
                'tag'                       => $articleData->tag ? $articleData->tag : "N/A",
                'publish_date'              => $articleData->created_at,
            ];
        });
//        dd($articleData);
        return Excel::download(new ArticlesExport($articleData), 'articles-'.date("d-m-y-H-i-s").'.csv');
=======

    public function exportArticles()
    {
        $articleData = Article::with(['user' => function ($q) {
            $q->select('id', 'first_name', 'last_name');
        }, 'category' => function ($q) {
            $q->select('id', 'name');
        }])->get()->map(function ($articleData) {
            return [
                'id' => $articleData->id,
                'en_title' => $articleData->en_title,
                'en_body' => strip_tags($articleData->en_body),
                'category_name' => $articleData->category->name,
                'author_name' => $articleData->user->first_name . ' ' . $articleData->user->last_name,
                'status' => $articleData->status,
                'tag' => $articleData->tag ? $articleData->tag : "N/A",
                'publish_date' => $articleData->created_at,
            ];
        });
//        dd($articleData);
        return Excel::download(new ArticlesExport($articleData), 'articles-' . date("d-m-y-H-i-s") . '.csv');
>>>>>>> 44cdcd7365250699f7a5fecf20bee265ffa52536
    }
}
