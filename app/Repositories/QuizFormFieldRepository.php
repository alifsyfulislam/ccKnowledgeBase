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
        $dataObj->quiz_form_id = $data['quiz_form_id'];
        $dataObj->f_label = $data['f_label'];
        $dataObj->f_name = $data['f_name'];
        $dataObj->f_id = $data['f_id'];
        $dataObj->f_class = $data['f_class'];
        $dataObj->f_type = $data['f_type'];
        $dataObj->f_option_value = $data['f_option_value'];
        $dataObj->f_default_value = $data['f_default_value'];
        $dataObj->f_max_value = $data['f_max_value'];
        $dataObj->f_sort_order = $data['f_sort_order'];
        $dataObj->f_required = $data['f_required'];

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
