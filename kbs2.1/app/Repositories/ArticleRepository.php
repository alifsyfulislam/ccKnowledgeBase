<?php

namespace App\Repositories;

use App\Helpers\Helper;
use App\Http\Traits\QueryTrait;
use App\Models\Article;
use App\Models\Comment;
use App\Models\Content;
use App\Models\User;
use Illuminate\Support\Str;
use Illuminate\Support\Collection;

class ArticleRepository implements RepositoryInterface
{
    use QueryTrait;
    /**
     * @return mixed
     */
    public function all()
    {

        return Article::with('user','category')->orderBy('id', 'DESC')->get();

    }

    public function latestArticleList($request)
    {
        if ($request->isAdmin){

            return Article::with('user','category')->orderBy('created_at', 'DESC')
                ->take(5)
                ->get();

        } else{

            $articles = Article::with('user','category','contents')
                ->where('status', 'public')
                ->orderBy('created_at', 'DESC')
                ->take(6)
                ->get()
                ->map(function ($query) {
                    $query->setRelation('contents', $query->contents->take(1));
                    return $query;
                });
            return $articles;
        }
    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Article::with('user','category','media','contents')->find($id);
        //return Content::select('role_id')->groupBy('role_id')->where('article_id',$id)->get();
    }

    // public function getArticleContents($id)
    // {
    //     return Content::select('role_id')->groupBy('role_id')->where('article_id',$id)->get();
    // }

    public function getAllUsers()
    {
        return User::all();
    }

    public function getBySlug($slug)
    {
        return Article::with('user','category','media','contents')
            ->where('slug', $slug)
            ->first();
    }

    /**
     * @param array $data
     * @return mixed
     */
    public function create(array $data)
    {
        $randomString = Str::random();

        $dataObj =  new Article;

        $dataObj->id          = $data['id'];
        $dataObj->user_id     = $data['user_id'];
        $dataObj->category_id = $data['category_id'];
        $dataObj->en_title    = $data['en_title'];
        $dataObj->bn_title    = $data['bn_title']? $data['bn_title'] : 'n/a';
        $dataObj->tag         = $data['tag'];
        $dataObj->slug        = Helper::slugify($data['en_title']).$randomString;
//        $dataObj->en_body     = $data['en_body']? $data['en_body'] : 'n/a';
//        $dataObj->bn_body     = $data['bn_body']? $data['bn_body'] : 'n/a';
        $dataObj->commentable_status      = $data['commentable_status'];
        $dataObj->is_notifiable           = $data['is_notifiable'];
        $dataObj->status      = $data['status'] ? $data['status'] :  'draft';
        $dataObj->publish_date = $data['publish_date'];
        $dataObj->en_short_summary = $data['en_short_summary'];
        $dataObj->bn_short_summary = $data['bn_short_summary']? $data['bn_short_summary'] : 'n/a';

        return $dataObj->save();

    }


    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return Article::find($id)->update($data);
    }


    /**
     * @param $idgit
     * @return mixed
     */
    public function delete($id)
    {

        $contents = Content::where('article_id', $id)->orderBy('created_at', 'desc')->get();
        $comments = Comment::where('post_id', $id)->orderBy('created_at', 'desc')->get();
        if ($contents){
            foreach ($contents as $content){
                $content->delete();
            }
        }

        if ($comments){
            foreach ($comments as $comment){
                $comment->delete();
            }
        }

        return Article::find($id)->delete();
    }


    /**
     * @param $request
     * @return mixed
     */
    public function getWithPagination($request)
    {

        $query = Article::with('user', 'category','history');
        $whereFilterList = ['category_id', 'status'];
        $likeFilterList = ['en_title', 'tag'];
        $query = self::filterArticle($request, $query, $whereFilterList, $likeFilterList);

        return $query->orderBy('id', 'DESC')->paginate(20);

    }


    /**
     * @param $request
     * @param $query
     * @param array $whereFilterList
     * @param array $likeFilterList
     * @return mixed
     */
    public static function filterArticle($request, $query, array $whereFilterList, array $likeFilterList)
    {
        $query = self::likeQueryFilter($request, $query, $likeFilterList);
        $query = self::whereQueryFilter($request, $query, $whereFilterList);

        if($request->filled('publish_date')){
            $query->whereDate('publish_date', '=', $request->publish_date);
        }

        return $query;
    }


    public function search(string $query = "")
    {


        $itemsPaginated =  Article::with('category','contents')
            ->whereHas('contents', function ($q) use ($query){
                $q->where('en_body', 'like', '%'.$query.'%');
            })
            ->orWhere('en_title', 'like', "%{$query}%")
            ->orWhere('tag', 'like', "%{$query}%")
            ->orWhere('en_short_summary', 'like', "%{$query}%")
            ->where('status', 'public')
            ->orderBy('created_at', 'DESC')->paginate(5);

        $itemsTransformed = $itemsPaginated
            ->getCollection()
            ->map(function($item) {
                return [
                    'id' => $item->id,
                    'user_id' => $item->user_id,
                    'category_id' => $item->category_id,
                    'en_title' => $item->en_title,
                    'bn_title' => $item->bn_title,
                    'tag' => $item->tag,
                    'slug' => $item->slug,
                    'en_short_summary' => $item->en_short_summary,
                    'bn_short_summary' => $item->bn_short_summary,
                    'commentable_status' => $item->commentable_status,
                    'status' => $item->status,
                    'publish_date' => $item->publish_date,
                    'created_at' => $item->created_at,
                    'updated_at' => $item->updated_at,
                    'category' => $item->category,
                    'contents' => $item->contents->take(1),
                ];
            })->toArray();

//        return $itemsTransformed;

        return $itemsTransformedAndPaginated = new \Illuminate\Pagination\LengthAwarePaginator(
            $itemsTransformed,
            $itemsPaginated->total(),
            $itemsPaginated->perPage(),
            $itemsPaginated->currentPage(), [
                'path' => \Request::url(),
                'query' => [
                    'page' => $itemsPaginated->currentPage()
                ]
            ]
        );

    }



    public function searchCategoryArticle($slug = '')
    {
        $itemsPaginated = Article::with('category','contents')
            ->whereHas('category', function ($q) use ($slug){
                $q->where('slug', $slug);
            })
            ->where('status', 'public')
            ->orderBy('created_at', 'DESC')
            ->paginate(5);

        $itemsTransformed = $itemsPaginated
            ->getCollection()
            ->map(function($item) {
                return [
                    'id' => $item->id,
                    'user_id' => $item->user_id,
                    'category_id' => $item->category_id,
                    'en_title' => $item->en_title,
                    'bn_title' => $item->bn_title,
                    'tag' => $item->tag,
                    'slug' => $item->slug,
                    'en_short_summary' => $item->en_short_summary,
                    'bn_short_summary' => $item->bn_short_summary,
                    'commentable_status' => $item->commentable_status,
                    'status' => $item->status,
                    'publish_date' => $item->publish_date,
                    'created_at' => $item->created_at,
                    'updated_at' => $item->updated_at,
                    'category' => $item->category,
                    'contents' => $item->contents->take(1),
                ];
            })->toArray();

//        return $itemsTransformed;

        return $itemsTransformedAndPaginated = new \Illuminate\Pagination\LengthAwarePaginator(
            $itemsTransformed,
            $itemsPaginated->total(),
            $itemsPaginated->perPage(),
            $itemsPaginated->currentPage(), [
                'path' => \Request::url(),
                'query' => [
                    'page' => $itemsPaginated->currentPage()
                ]
            ]
        );

        return $itemsPaginated;

    }


    public function changeStatus($request){

        return Article::where('id', $request->id)->update([

            'status' => $request->status

        ]);

    }

}
