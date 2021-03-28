<?php


namespace App\Repositories;


use App\Helpers\Helper;
use App\Models\Banner;

class BannerRepository
{
    public function create(array $data)
    {

        $dataObj =  new Banner();

        $dataObj->id = $data['id'];
        $dataObj->title = $data['title'];
        $dataObj->status = $data['status'];
        $dataObj->slug = Helper::slugify($data['title']);
        $dataObj->role_id = $data['role_id'];

        return $dataObj->save();
    }


    public function get($id)
    {
        return Banner::with('media')
            ->where('id', $id)
            ->first();

        //return Category::with(['permissions' => function($q) {$q->select('id', 'name');}])->find($id);

    }

    public function getWithPagination()
    {

        return Banner::with('media')->orderBy('id','DESC')->paginate(20);

    }
}