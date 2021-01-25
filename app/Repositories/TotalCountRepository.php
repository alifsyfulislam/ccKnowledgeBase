<?php


namespace App\Repositories;


class TotalCountRepository
{
    public function allTotalCount($request)
    {
        if ($request->isAdmin){

            return Article::with('user','category')->orderBy('created_at', 'DESC')
                ->take(5)
                ->get();

        } else{

            return Article::with('user','category')
                ->where('status', 'public')
                ->orderBy('created_at', 'DESC')
                ->take(5)
                ->get();
        }
    }
}
