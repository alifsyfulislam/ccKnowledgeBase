<?php


namespace App\Repositories;


use App\Helpers\Helper;
use App\Models\Banner;
use App\Models\Media;


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

    public function update($input){

        $banner = Banner::find($input['id']);
        $banner->title = $input['title'];
        $banner->slug = Helper::slugify($input['title']);
        $banner->status = $input['status'];
        $banner->role_id = $input['role_id'];
        $banner->save();
        return $banner;

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

    public function delete($id){



        $banner = Banner::where('id',$id)->first();

//        return $banner;

        if ($banner){
            $banner->delete();

            $media = Media::where('mediable_id', $id)->first();
            $mediaName =  substr($media->url, strpos($media->url, "media") );

            if ($mediaName){


                unlink(public_path().'/'.$mediaName );
                $media->delete();

            }

//            $media->delete();

        }

    }
}