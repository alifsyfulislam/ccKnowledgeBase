<?php


namespace App\Helpers;

use Auth;
use Intervention\Image\Facades\Image as Image;
use App\Notifications\NewArticleNotify;
use App\Notifications\UpdateArticleNotify;
use App\Notifications\DeleteArticleNotify;
use App\Notifications\NewFaqNotify;
use App\Notifications\UpdateFaqNotify;
use App\Notifications\DeleteFaqNotify;
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

    public static function sendArticleNotification($article, $users, $type) {


        $roles = [];
        $contents = $article->contents;
        if(!empty( $contents)) {
            foreach($contents  as $content) {
                $roleIds = explode(',',$content->role_id);
                 foreach($roleIds as $roleId) {
                     if(!in_array($roleId, $roles)) {
                         array_push($roles, $roleId);
                     }
                 }
             }
            
             foreach($users as $user) {
                if(in_array($user->userRole->role_id, $roles)) {

                    switch($type) {
                        case "add":
                            $user->notify(new NewArticleNotify($article, $user));
                            break;
                        case "update": 
                            $user->notify(new UpdateArticleNotify($article, $user));
                            break;
                        case "delete": 
                            $user->notify(new DeleteArticleNotify($article, $user));  
                            break;         
                    }
                }
            }
        }
        return null; 
    }
    public static function sendFaqNotification($faq, $users, $type) {


        $roles = [];
        $contents = $faq->contents;
        if(!empty( $contents)) {
            foreach($contents  as $content) {
                $roleIds = explode(',',$content->role_id);
                 foreach($roleIds as $roleId) {
                     if(!in_array($roleId, $roles)) {
                         array_push($roles, $roleId);
                     }
                 }
             }
            
             foreach($users as $user) {
                if(in_array($user->userRole->role_id, $roles)) {

                    switch($type) {
                        case "add":
                            $user->notify(new NewFaqNotify($faq, $user));
                            break;
                        case "update": 
                            $user->notify(new UpdateFaqNotify($faq, $user));
                            break;
                        case "delete": 
                            $user->notify(new DeleteFaqNotify($faq, $user));
                            break;         
                    }
                }
            }
        }
        return null;  
    }

    public static function calculateResult($totalMarks, $numberOfQuestions, $resultData) {
        $score = 0;
        $numberOfCorrectAnswer = 0;
        $perQuestionmark = $totalMarks/$numberOfQuestions;
        foreach($resultData as $data) {
         if($data->question->f_default_value == $data->answer)   
            $numberOfCorrectAnswer++;
        }
        return  $score = $numberOfCorrectAnswer*$perQuestionmark;
    }

    public static function getClientIpAddress() {
        $ipaddress = '';
        if (isset($_SERVER['HTTP_CLIENT_IP']))
            $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
        else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_X_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
        else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_FORWARDED'];
        else if(isset($_SERVER['REMOTE_ADDR']))
            $ipaddress = $_SERVER['REMOTE_ADDR'];
        else
            $ipaddress = 'UNKNOWN';
        return $ipaddress;
    }
}
