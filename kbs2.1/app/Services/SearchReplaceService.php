<?php


namespace App\Services;


use App\Repositories\searchReplaceRepository;
use Nyholm\Psr7\Request;

class SearchReplaceService
{
    protected $searchReplaceRepository;

    public function __construct(searchReplaceRepository $searchReplaceRepository)
    {

        $this->searchReplaceRepository = $searchReplaceRepository;

    }

    public function getSearchResult($post_id,$search){

        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article' => $this->searchReplaceRepository->search($post_id,$search)
        ]);
    }

    public function getReplaceResult($post_id,$search,$request){
        return response()->json([
            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'article' => $this->searchReplaceRepository->replace($post_id,$search, $request)
        ]);
    }
}