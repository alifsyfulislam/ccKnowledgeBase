<?php

namespace App\Repositories;


use App\Helpers\Helper;
use App\Models\Category;

class CategoryRepository implements RepositoryInterface
{

    /**
     * @return mixed
     */
    public function all()
    {

        return Category::with('childrenRecursive')->where('parent_id', '=', 0)->orderBy('name', 'ASC')->get();

    }



    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Category::find($id);

        //return Category::with(['permissions' => function($q) {$q->select('id', 'name');}])->find($id);

    }

    /**
     * @param array $data
     * @return bool
     */
    public function create(array $data)
    {

        $dataObj =  new Category;

        $dataObj->id = $data['id'];
        $dataObj->name = $data['name'];
        $dataObj->slug = Helper::slugify($data['name']);
        $dataObj->parent_id = $data['parent_id'];

        return $dataObj->save();
    }

    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
        return Category::find($id)->update($data);
    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {
        self::deleteSubcategory($id);

        $selectedCategory = Category::where('id', $id)->get();
        $child = Category::where('parent_id', $id)->get();

        if(count($selectedCategory) == 0):

            echo json_encode ($this->error("Category Not Found!", "400"));

        elseif(count($child) == 0 ):
            echo json_encode($this->success("No Child!! Deleted..",'', 200));
            return Category::find($id)->delete();
        else:
            echo json_encode($this->error(count($child)." subcategories Found!! You cann't delete this", 400));

        endif;

    }


    /**
     * @param $category_id
     */
    public function deleteSubcategory($category_id){
       $request = Category::where('parent_id', '=', $category_id)->pluck('id');
       //print_r($request);
       //echo count($request);
       foreach ($request as $cat){
           //echo 444;
           echo('Id :'.$cat.',  ');

           self::deleteSubcategory($cat);

        }
        //echo 'hi';
        echo Category::where('id', '=', $category_id)->delete();


    }
    /*
    public function getWithPagination()
    {
        return Category::orderBy('id', 'DESC')->paginate(10);
    }
    */
}
