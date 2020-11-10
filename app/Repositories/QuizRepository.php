<?php


namespace App\Repositories;


use App\Models\Quiz;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class QuizRepository
{
    /**
     * @return mixed
     */
    public function all()
    {

        return Quiz::with('QuizForm')->orderBy('created_at', 'DESC')->get();

    }


    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Quiz::findOrFail($id);
    }


    /**
     * @param array $data
     * @return mixed
     */
    public function create(array $data)
    {

        $dataObj =  new Quiz;

        $dataObj->id  = $data['id'];
        $dataObj->article_id = $data['article_id'];
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
        return Quiz::find($id)->update($data);
    }


    /**
     * @param $id
     */
    public function delete($id)
    {
        return Quiz::find($id)->delete();
    }


    /**
     * @return LengthAwarePaginator
     */
    public function getWithPagination()
    {
        return Quiz::with('QuizForm')->orderBy('created_at', 'DESC')->paginate(10);
    }
}
