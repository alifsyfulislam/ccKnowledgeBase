<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\CategoryService;
use Auth;

class CategoryController extends Controller
{
    /**
     * @var CategoryService
     */
    protected $categoryService;

    /**
     * CategoryController constructor.
     * @param CategoryService $categoryService
     *
     */
    public function __construct(CategoryService $categoryService)
    {
        $this->categoryService = $categoryService;
    }

    /**
     * @return mixed
     */
    public function index(Request $request)
    {
<<<<<<< HEAD
//        print_r($request->all());
=======
        
        if(Auth::user()->can('category-list')) {
>>>>>>> 736ae50711e9a188480c561bfb62d2cf617e40fd

            if ($request->filled('isAdmin'))
                return $this->categoryService->paginateData($request);
            else
                return $this->categoryService->getAll();

        } else {

            return response()->json([
                'status_code' => 424,
                'messages'=>'User does not have the right permissions'
            ]);

        }

    }

    public function store(Request $request)
    {

        if(Auth::user()->can('category-create')) {

            return $this->categoryService->createItem($request);

        } else {

            return response()->json([
                'status_code' => 424,
                'messages'=>'User does not have the right permissions'
            ]);

        }

    }

    public function show($id)
    {
        
        if(Auth::user()->can('category-list')) {

            return $this->categoryService->getById($id);

        } else {

            return response()->json([
                'status_code' => 424,
                'messages'=>'User does not have the right permissions'
            ]);

        }

    }

    public function update(Request $request)
    {
        
        if(Auth::user()->can('category-edit')) {

            return $this->categoryService->updateItem($request);

        } else {

            return response()->json([
                'status_code' => 424,
                'messages'=>'User does not have the right permissions'
            ]);

        }
    }


    public function destroy(Request $request)
    {
        
        if(Auth::user()->can('category-delete')) {

            return  $this->categoryService->deleteItem($request->id);

        } else {

            return response()->json([
                'status_code' => 424,
                'messages'=>'User does not have the right permissions'
            ]);
        }

    }


    public function categoryList()
    {

        return $this->categoryService->getAll();

    }


    public function categoryArticleList()
    {

        return $this->categoryService->categoryArticles();

    }

    public function checkCategoryNameExist(Request $request)
    {

        return $this->categoryService->getCategoryNameExist($request);

    }

    public function getCategoryForEdit(Request $request)
    {

        return $this->categoryService->getCategoryListForUpdate($request);

    }

}
