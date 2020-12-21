<?php


namespace App\Repositories;

use App\Http\Traits\QueryTrait;
use App\Models\Page;

class PageRepository
{

    use QueryTrait;
    /**
     * @return mixed
     */
    public function all()
    {

        return Page::Query()
            ->first();

    }


    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Page::findOrFail($id);
    }


    /**
     * @param array $data
     * @return mixed
     */
    public function create(array $data)
    {

        $dataObj =  new Page;

        $dataObj->id  = $data['id'];
        // $dataObj->article_id = $data['article_id'];
        $dataObj->quiz_form_id = $data['quiz_form_id'];
        $dataObj->name = $data['name'];
        $dataObj->slug = $data['slug'];
        $dataObj->duration = $data['duration'];
        $dataObj->total_marks = $data['total_marks'];
        $dataObj->number_of_questions = $data['number_of_questions'];
        $dataObj->status = $data['status'];

        return $dataObj->save();
    }


    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return Page::find($id)->update($data);
    }



}
