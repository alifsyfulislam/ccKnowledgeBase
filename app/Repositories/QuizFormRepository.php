<?php


namespace App\Repositories;


use App\Helpers\Helper;
use App\Models\QuizForm;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class QuizFormRepository
{

    /**
     * @return mixed
     */
    public function all()
    {

        return QuizForm::orderBy('created_at', 'DESC')->get();

    }


    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {

        return QuizForm::findOrFail($id);

    }


    /**
     * @param array $data
     * @return mixed
     */
    public function create(array $data)
    {

        $dataObj =  new QuizForm;
        $dataObj->id = $data['id'];
        $dataObj->user_id = $data['user_id'];
        $dataObj->category_id = $data['category_id'];
        $dataObj->en_title = $data['en_title'];
        $dataObj->bn_title = $data['bn_title'];
        $dataObj->slug = Helper::slugify($data['en_title']);
        $dataObj->en_short_summary = $data['en_short_summary'];
        $dataObj->bn_short_summary = $data['bn_short_summary'];
        $dataObj->en_body = $data['en_body'];
        $dataObj->bn_body = $data['bn_body'];
        $dataObj->status = $data['status'];
        $dataObj->publish_date = $data['publish_date'];

        return $dataObj->save();

    }


    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return QuizForm::find($id)->update($data);
    }


    /**
     * @param $id
     */
    public function delete($id)
    {
        return QuizForm::find($id)->delete();
    }


    /**
     * @return LengthAwarePaginator
     */
    public function getWithPagination()
    {
        return QuizForm::orderBy('created_at', 'DESC')->paginate(10);
    }

}
