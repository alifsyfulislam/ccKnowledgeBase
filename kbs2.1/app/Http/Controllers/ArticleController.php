<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Services\ArticleService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ArticleController extends Controller
{

    protected $articleService;

    public function __construct(ArticleService $articleService)
    {

        //$this->middleware("auth");
        $this->articleService = $articleService;

    }

    /**
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function index(Request $request)
    {

        if(Auth::user()->can('article-list')) {

            return $this->articleService->paginateData($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return void
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function store(Request $request)
    {

        if(Auth::user()->can('article-create')) {

            return $this->articleService->createItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

    }

    /**
     * Display the specified resource.
     *
     * @param Article $article
     * @return JsonResponse
     */
    public function show($id)
    {

        return $this->articleService->getById($id);
    }

    public function articleDetails($slug)
    {

        return $this->articleService->getArticleDetailsBySlug($slug);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param Article $article
     * @return void
     */
    public function edit(Article $article)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param Article $article
     * @return JsonResponse
     */
    public function update(Request $request)
    {

        if(Auth::user()->can('article-edit')) {

            return $this->articleService->updateItem($request);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Article $article
     * @return JsonResponse
     */
    public function destroy(Request $request)
    {
        if(Auth::user()->can('article-delete')) {

            return  $this->articleService->deleteItem($request->id);

        } else {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }
    }

    /**
     * @param Request $request
     * @param Article $article
     * @return JsonResponse
     */
    public function articleSearch(string $searchString = "")
    {

        return $this->articleService->searchArticle($searchString);

    }

    /**
     * @param $id
     * @return JsonResponse
     */
    public function articleCategory($id)
    {

        return $this->articleService->categoryArticle($id);

    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function articleList(Request $request)
    {

        return $this->articleService->getLatestList($request);

    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function saveFiles(Request $request)
    {

        return $this->articleService->saveFiles($request);

    }

    /**
     * @param Request $request
     * @return JsonResponse
     */
    public function deleteFiles(Request $request)
    {

        return $this->articleService->deleteFiles($request);

    }

}
