<?php


namespace App\Helpers;

use Auth;
use Intervention\Image\Facades\Image as Image;


class Helper
{

    public static function slugify($value)
    {
        // return strtolower(str_replace(' ','-',$value));
        return strtolower(preg_replace("/[^a-zA-Z0-9]+/", "-", $value));

    }

    /**
     * @param $url
     * @param $image
     * @return string
     */
    public static function base64ProfileImageThumbUpload($url, $image)
    {
        $fileName = time () .".jpg";
        $dir = "media/".$url."/".Auth::user()->id."/thumbs/";

        if (!file_exists(public_path ($dir))) {

            mkdir(public_path ($dir), 0755, true);

        }

        $small_image = Image::make($image);
        $thumbImage = $small_image->resize(null, 250, function ($e) {

            $e->aspectRatio();

        });

        $thumbImage->save(public_path($dir. $fileName ));

        return url('/').'/'.$dir.$fileName;
    }

    public static function videoUpload($url, $video)
    {
        $file = $video;
        $fileName = time().'.'.$file->getClientOriginalExtension();
        $dir = "media/".$url."/";

        if (!file_exists(public_path ($dir))) {

            mkdir(public_path ($dir), 0755, true);
        }

        $file->move(public_path($dir), $fileName );

        return url('/').'/'.$dir.$fileName;

    }


    /**
     * @param $url
     * @param $image
     * @return string
     */
    public static function base64ImageUpload($url, $image)
    {
        $fileName = uniqid().'.'.$image->getClientOriginalExtension();
        $dir = "media/".$url."/";

        if (!file_exists(public_path ($dir))) {

            mkdir(public_path ($dir), 0755, true);

        }

        $small_image = Image::make($image);
        $thumbImage = $small_image->resize(350, null, function ($e) {

            $e->aspectRatio();

        });

        $thumbImage->save(public_path($dir. $fileName ));

        return url('/').'/'.$dir.$fileName;
    }

    public static function base64PageLogoUpload($url, $image)
    {
        $file = $image;
        $fileName = uniqid().'.'.$image->getClientOriginalExtension();
        $dir = "media/".$url."/";

        if (!file_exists(public_path ($dir))) {

            mkdir(public_path ($dir), 0755, true);
        }

        $file->move(public_path($dir), $fileName );

        return url('/').'/'.$dir.$fileName;
    }
}
