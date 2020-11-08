<?php

namespace App\Http\Controllers\Api;

use App\Models\Article;
use App\Http\Controllers\Controller;
use App\Services\ArticleService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ArticleController extends Controller
{

    protected $articleService;

    public function __construct(ArticleService $articleService)
    {

        $this->middleware('permission:article-list');
        $this->middleware('permission:article-create', ['only' => ['create','store']]);
        $this->middleware('permission:article-edit', ['only' => ['edit','update']]);
        $this->middleware('permission:article-delete', ['only' => ['destroy']]);
        $this->articleService = $articleService;

    }

    /**
     * Display a listing of the resource.
     *
     * @return JsonResponse
     */
    public function index()
    {
        return $this->articleService->paginateData();
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

        return $this->articleService->createItem($request);

    }

    /**
     * Display the specified resource.
     *
     * @param Article $article
     * @return void
     */
    public function show(Article $article)
    {
        //
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
     * @return void
     */
    public function update(Request $request, Article $article)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Article $article
     * @return void
     */
    public function destroy(Article $article)
    {
        //
    }
}
