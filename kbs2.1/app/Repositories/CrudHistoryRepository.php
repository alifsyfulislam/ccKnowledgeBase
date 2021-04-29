<?php


namespace App\Repositories;


use App\Models\CrudHistory;

class CrudHistoryRepository
{
    public function getWithPagination($post_id)
    {

        return CrudHistory::with('user')->where('post_id',$post_id)->orderBy('created_at','DESC')->paginate(20);

    }
}