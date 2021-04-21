<?php

namespace App\Http\Controllers;

use App\Models\CrudHistory;
use Illuminate\Http\Request;

class CrudHistoryController extends Controller
{
    //
    public function index($post_id){
        return CrudHistory::with('user')->where('post_id',$post_id)->orderBy('created_at','DESC')->paginate(20);
    }
}
