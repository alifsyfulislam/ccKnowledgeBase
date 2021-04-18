<?php


namespace App\Helpers;

use Auth;
use Intervention\Image\Facades\Image as Image;
use App\Notifications\NewArticleNotify;
use App\Notifications\UpdateArticleNotify;
use App\Notifications\DeleteArticleNotify;
use Illuminate\Support\Facades\Notification;
use Illuminate\Notifications\Notifiable;


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

    public static function fileUpload($url, $file)
    {
        //$fileName = $file->getClientOriginalName().'_'.time(). '.' . $file->getClientOriginalExtension();
        $fileName = time().'_'.$file->getClientOriginalName();

        $dir = "media/" . $url . "/";

        if (!file_exists(public_path($dir))) {

            mkdir(public_path($dir), 0755, true);

        }

        $file->move(public_path($dir), $fileName);

        return url('/') . '/' . $dir . $fileName;

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

    public static function sendNotification($article, $users, $type) {


        $roles = [];
        $contents = $article->contents;
        if(!empty( $contents)) {
            foreach($contents  as $content) {
                $role_ids = explode(',',$content->role_id);
                 foreach($role_ids as $role_id) {
                     if(!in_array($role_id, $roles)) {
                         array_push($roles, $role_id);
                     }
                 }
             }
            
             foreach($users as $user) {
                if(in_array($user->userRole->role_id, $roles)) {
                   
                    if($type=="add") {
                        // Notification::route('mail', $user->email)->notify(new NewArticleNotify($article));//Sending mail to user
                        $user->notify(new NewArticleNotify($article, $user));
                    } else if($type=="update") {
                        $user->notify(new UpdateArticleNotify($article, $user));
                    } else if($type=="delete") {
                        $user->notify(new DeleteArticleNotify($article, $user));
                        
                    }
                }
            }

        }
        
        return null;
       
    }
}
