<?php


namespace App\Repositories;


use App\Http\Traits\QueryTrait;
use App\Models\Quiz;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class QuizRepository
{
    use QueryTrait;
    /**
     * @return mixed
     */
    public function all()
    {

        return Quiz::with('QuizForm')
            ->orderBy('created_at', 'DESC')
            ->get();

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
       // $dataObj->article_id = $data['article_id'];
        $dataObj->quiz_form_id = $data['quiz_form_id'];
        $dataObj->name = $data['name'];
        $dataObj->slug = $data['slug'];
        $dataObj->duration = $data['duration'];
        $dataObj->total_marks = $data['total_marks'];
        $dataObj->number_of_questions = $data['number_of_questions'];
        $dataObj->status = $data['status'];
        $dataObj->is_authorized = $data['is_authorized'];
        if( $dataObj->is_authorized!==0) {
            $dataObj->role_id = implode(',',$data['role_id']);
        }else{
            $dataObj->role_id = 0;
        }
       

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
        // $quiz = Quiz::find($id);
        // $quiz->role_id = implode(',',$data['role_id']);
        // return $quiz->update($data);

    }


    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        return Quiz::find($id)->delete();
    }


    /**
     * @return LengthAwarePaginator
     */
    public function getWithPagination($request)
    {

        $query = Quiz::with('QuizForm');
        $whereFilterList = ['status'];
        $likeFilterList  = ['name'];
        $query = self::filterQuiz($request, $query, $whereFilterList, $likeFilterList);

        return $query->orderBy('id', 'DESC')->paginate(20);

    }

    public static function filterQuiz($request, $query, array $whereFilterList, array $likeFilterList)
    {

        $query = self::likeQueryFilter($request, $query, $likeFilterList);
        $query = self::whereQueryFilter($request, $query, $whereFilterList);

        return $query;

    }
}
