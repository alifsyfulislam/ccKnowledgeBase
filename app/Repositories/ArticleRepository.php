<?php

namespace App\Repositories;

use App\Helpers\Helper;
use App\Http\Traits\QueryTrait;
use App\Models\Article;
use App\Models\Media;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\Str;

class ArticleRepository implements RepositoryInterface
{
    use QueryTrait;
    /**
     * @return mixed
     */
    public function all()
    {

        return Article::orderBy('id', 'DESC')->get();

    }

    public function latestArticleList($request)
    {
        if ($request->isAdmin){
            return Article::with('user','category')
                ->orderBy('created_at', 'DESC')
                ->take(5)
                ->get();
        }
        else
            return Article::orderBy('created_at', 'DESC')->take(5)->get();

    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Article::with('user','category')->find($id);
    }

    public function getBySlug($slug)
    {
        return Article::with('user','category')
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
        $dataObj->bn_title    = $data['bn_title'];
        $dataObj->tag         = $data['tag'];
        $dataObj->slug        = Helper::slugify($data['en_title']).$randomString;
        $dataObj->en_body     = $data['en_body'];
        $dataObj->bn_body     = $data['bn_body'];
        $dataObj->status      = $data['status'] ?? 'draft';
        $dataObj->publish_date = $data['publish_date'];
        $dataObj->en_short_summary = $data['en_short_summary'];
        $dataObj->bn_short_summary = $data['bn_short_summary'];

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
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        return Article::find($id)->delete();
    }


    /**
     * @param $request
     * @return mixed
     */
    public function getWithPagination($request)
    {

        $query = Article::with('user', 'category');
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
        return Article::with('category')->where('en_title', 'like', "%{$query}%")
            ->orWhere('tag', 'like', "%{$query}%")
            ->orWhere('en_short_summary', 'like', "%{$query}%")
            ->orWhere('en_body', 'like', "%{$query}%")
            ->orderBy('id', 'DESC')->paginate(5);
    }



    public function searchCategoryArticle($slug = '')
    {
        $query = Article::Query();

        $query = $query->whereHas('category', function ($q) use ($slug) {

            $q->where('slug', $slug);

        });

        return $query->orderBy('id', 'DESC')->paginate(5);
    }
}
