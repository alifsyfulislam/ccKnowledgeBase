<?php


namespace App\Services;

use App\Helpers\Helper;
use App\Models\Media;
use App\Models\User;
use App\Repositories\ArticleRepository;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Exception;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use App\Notifications\NewArticleNotify;
use Illuminate\Support\Facades\Notification;
use Illuminate\Notifications\Notifiable;

class ArticleService
{
    /**
     * @var ArticleRepository
     */
    protected $articleRepository;

    public function __construct(ArticleRepository $articleRepository)
    {

        $this->articleRepository = $articleRepository;

    }

    /**
     * @return JsonResponse
     */
    public function getAll()
    {

        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->all()
        ]);

    }

    public function getLatestList($request)
    {

        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->latestArticleList($request)
        ]);
    }

    public function getAllArticleList(){
        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->all()
        ]);
    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function createItem(Request $request)
    {
        $thumbFile = [];

        $validator = Validator::make($request->all(),[
            'en_title'    => 'required|min:3|max:190',
            'category_id' => 'required',
        ]);

        if($validator->fails()) {

            return response()->json([
                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()
            ]);

        }

        $input = $request->all();

        $input['id'] = $request->id;
        $input['user_id'] = auth()->user()->id;
        $input['publish_date'] = date('Y-m-d H:i:s');

        $thumbImageList = $request->uploaded_file;

        DB::beginTransaction();

        try {

            $this->articleRepository->create($input);

            $article = $this->getItemById($input['id']);
            
           
            if(isset($request->uploaded_file) && count($request->uploaded_file)>0) {

                if (isset($request->uploaded_file)) {

                    $fileLength = count($thumbImageList);

                    if (count($thumbImageList) > 0) {
                        for ($i = 1; $i <= $fileLength; $i++) {
//                              dd($thumbImageList[count($thumbImageList) - $i]);
                            $thumbFile[] = Helper::fileUpload("article/files", $thumbImageList[count($thumbImageList) - $i]);
                        }
                    }
                }

                foreach ($thumbFile as $file):
//                    dd($thumbFile);

                    $article->media()->create([

                        'url' => $file

                    ]);

                endforeach;
            }

            //notification
            // $article_contents =  $this->articleRepository->getArticleContents($article->id);
            $users = $this->articleRepository->getAllUsers();
            $notifications = Helper::sendNotification($article, $users, 'add');

        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 201,
            'messages'=>config('status.status_code.201')
        ]);

    }



    public function getItemById($id)
    {

        return $this->articleRepository->get($id);
    }

    /**
     * @param $id
     * @return JsonResponse
     */

    public function getById($id)
    {

        if($this->articleRepository->get($id))

            return response()->json([
                'status_code'  => 200,
                'messages'     => config('status.status_code.200'),
                'article_info' => $this->articleRepository->get($id)
            ]);

        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_info' => "Data not found"
        ]);

    }

    public function getArticleDetailsBySlug($slug)
    {

        if($this->articleRepository->getBySlug($slug))

            return response()->json([
                'status_code'  => 200,
                'messages'     => config('status.status_code.200'),
                'article_info' => $this->articleRepository->getBySlug($slug)
            ]);

        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_info' => "Data not found"
        ]);

    }

    /**
     * @param $request
     * @return JsonResponse
     */
    public function updateItem($request)
    {

        $validator = Validator::make($request->all(),[

            'en_title'    => 'required|string',
            'category_id' => 'required',

        ]);

        if($validator->fails()) {

            return response()->json([

                'status_code' => 400,
                'messages'    => config('status.status_code.400'),
                'errors'      => $validator->errors()->all()

            ]);

        }

        $input          = $request->all();
        $randomString   = Str::random();
        $input['slug']  = Helper::slugify($input['en_title']).$randomString;

        DB::beginTransaction();

        try {

//            $this->articleRepository->update($input, $input['id']);

            $this->articleRepository->update($input, $input['id']);

            $uploaded_previous_file = json_decode($request->previous_file_list);

            if (empty($uploaded_previous_file)){
                $mediaList = Media::where('mediable_id', $request->id)->get();

                if (count($mediaList) > 0){
                    foreach ($mediaList as $media){
                        $mediaName = substr($media->url, strpos($media->url, "media"));
                        unlink(public_path().'/'.$mediaName);
                        Media::find($media->id)->delete();
                    }
                }
            }

            if (isset($uploaded_previous_file) && count($uploaded_previous_file) > 0){
                $previousFileIds = array_column($uploaded_previous_file, 'id');
                $previousMediaList = Media::where('mediable_id', $request->id)->get();
                $previousMediaListIdArray = $previousMediaList->pluck('id')->toArray();

                $previousFileDiff = array_diff($previousMediaListIdArray,$previousFileIds);

                if ($previousFileDiff){
                    foreach($previousFileDiff as $aPreviousMedia)
                    {
                        $media = Media::where('id', $aPreviousMedia)->first();
                        $mediaName =  substr($media->url, strpos($media->url, "media") );
                        unlink(public_path().'/'.$mediaName );
                        Media::find($aPreviousMedia)->delete();

                    }
                }
            }

            if(isset($request->uploaded_file) && count($request->uploaded_file)>0) {

                $article = $this->getItemById($request->id);

                $thumbImageList = $request->uploaded_file;

                $fileLength = count($thumbImageList);

                if(count($thumbImageList) > 0) {
                    for ($i = 1; $i <= $fileLength; $i++) {

                        $thumbFile[] = Helper::fileUpload("article/files", $thumbImageList[count($thumbImageList) - $i]);

                    }
                }

                foreach ($thumbFile as $file):

                    $article->media()->create([

                        'url' => $file

                    ]);

                endforeach;
            }
            $article = $this->getItemById($input['id']);
            $users = $this->articleRepository->getAllUsers();
            $notifications = Helper::sendNotification($article, $users, 'update');

        } catch (Exception $e) {

            DB::rollBack();
            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);
        }

        DB::commit();

        return response()->json([
            'status_code' => 200,
            'messages'    => config('status.status_code.200')
        ]);
    }


    /**
     * @param $id
     * @return JsonResponse
     */
    public function deleteItem($id)
    {
        DB::beginTransaction();

        try {

            $article = $this->getItemById($id);
            $users = $this->articleRepository->getAllUsers();
            $notifications = Helper::sendNotification($article, $users, 'delete');

            $this->articleRepository->delete($id);

        } catch (Exception $e) {

            DB::rollBack();

            Log::error('Found Exception: ' . $e->getMessage() . ' [Script: ' . __CLASS__ . '@' . __FUNCTION__ . '] [Origin: ' . $e->getFile() . '-' . $e->getLine() . ']');

            return response()->json([
                'status_code' => 424,
                'messages'    => config('status.status_code.424'),
                'error'       => $e->getMessage()
            ]);

        }

        DB::commit();

        return response()->json([

            'status_code' => 200,
            'messages'    => "Article Deleted Successfully"

        ]);

    }

    /**
     * @return JsonResponse
     */
    public function paginateData($request)
    {

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->getWithPagination($request)

        ]);

    }

    public function searchArticle($searchString)
    {

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->search($searchString)

        ]);

    }


    public function categoryArticle($id)
    {

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_list' => $this->articleRepository->searchCategoryArticle($id)

        ]);

    }


    public function saveFiles($request)
    {

        if(isset($request->file)) {

            return response()->json([

                'status_code' => 200,
                'messages'    => config('status.status_code.200'),
                'file_path'   => Helper::base64ImageUpload($request->attachment_save_path, $request->file)

            ]);

        }

    }


    public function deleteFiles($request)
    {

        if(isset($request->img_src)) {

            $mediaName = substr($request->img_src, strpos($request->img_src, "media"));

            unlink(public_path().'/'.$mediaName );

            return response()->json([
                'status_code' => 200,
                'messages'    => config('status.status_code.200'),
            ]);

        }

    }

    public function articleStatusChange($request)
    {

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article_info' => $this->articleRepository->changeStatus($request)

        ]);

    }


}
