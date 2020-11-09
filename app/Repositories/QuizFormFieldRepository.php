<?php


namespace App\Repositories;

use App\Models\QuizFormField;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class QuizFormFieldRepository
{

    /**
     * @return mixed
     */
    public function all()
    {

        return QuizFormField::orderBy('created_at', 'DESC')->get();

    }


    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return QuizFormField::findOrFail($id);
    }


    /**
     * @param array $data
     * @return mixed
     */
    public function create(array $data)
    {

        $dataObj =  new QuizFormField;
        $dataObj->name = $data['name'];
        $dataObj->slug = $data['slug'];

        return $dataObj->save();
    }


    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return QuizFormField::find($id)->update($data);
    }


    /**
     * @param $id
     */
    public function delete($id)
    {
        return QuizFormField::find($id)->delete();
    }


    /**
     * @return LengthAwarePaginator
     */
    public function getWithPagination()
    {
        return QuizFormField::with('quizForm')->orderBy('created_at', 'DESC')->paginate(10);
    }
}
