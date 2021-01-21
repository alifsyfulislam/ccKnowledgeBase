<?php

namespace App\Repositories;


use App\Helpers\Helper;
use App\Models\Category;
use Illuminate\Support\Facades\DB;

class CategoryRepository implements RepositoryInterface
{
    public $subCat =[];

    /**
     * @return mixed
     */

    public function all()
    {
        return Category::with('childrenRecursive')
            ->where('parent_id', '=', 0)
            ->orderBy('id','DESC')
            ->get();

    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        return Category::with('media')
            ->where('id', $id)
            ->first();

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
        $dataObj->parent_id = $data['parent_id'] ?? 0;

        return $dataObj->save();
    }

    /**
     * @param array $data
     * @param $id
     * @return mixed
     */
    public function update(array $data, $id)
    {
       // dd($data);

        return Category::where('id', $id )->update([
            'name'      => $data['name'],
            'parent_id' => $data['parent_id'] ?? 0
        ]);

    }

    /**
     * @param $id
     * @return mixed
     */
    public function delete($id)
    {

        self::deleteSubcategory($id);

    }


    /**
     * @param $category_id
     */
    public static function deleteSubcategory($category_id){

       $request = Category::where('parent_id', '=', $category_id)->pluck('id');

       foreach ($request as $cat){

           self::deleteSubcategory($cat);

        }
        //echo 'hi';
        Category::where('id', '=', $category_id)->delete();

    }

    public function getWithPagination($request)
    {
        if ($request->filled('without_pagination')) {

            return Category::with('parentRecursive', 'media')
                ->orderBy('id','DESC')
                ->get();

        }
        else{
            return Category::with('parentRecursive', 'media')
                ->orderBy('id','DESC')
                ->paginate(20);
        }


    }

    public function categoryArticles()
    {

        return Category::with(['article','media'])->orderBy('id','DESC')->get()->map(function ($query) {

                $query->setRelation('article', $query->article->take(-3));
                return $query;

        });
//        return Category::with(['article','media'])->latest()->take(5)->get();

    }

    public function categoryListForUpdate($request)
    {

        $categoryChildArray = Category::where('id', '!=', $request->id)
            ->where('parent_id',  $request->id)
            ->pluck('id')->toArray();

        $categoryChildArray[] = $request->id;

       // dd($categoryChildArray);

        $categoryList = DB::table('categories')
            ->whereNotIn('id', $categoryChildArray)
            ->whereNotIn('parent_id',$categoryChildArray)->get();

        return $categoryList;

    }
}
