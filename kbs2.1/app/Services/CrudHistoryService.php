<?php


namespace App\Services;


use App\Repositories\CrudHistoryRepository;

class CrudHistoryService
{

    protected $crudHistoryRepository;

    public function __construct(CrudHistoryRepository $crudHistoryRepository)
    {

        $this->crudHistoryRepository = $crudHistoryRepository;

    }

    public function paginateData($post_id)
    {

        return response()->json([

            'status_code'  => 200,
            'messages'     => config('status.status_code.200'),
            'history_list' => $this->crudHistoryRepository->getWithPagination($post_id)

        ]);

    }

}