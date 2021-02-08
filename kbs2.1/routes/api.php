<?php


use Illuminate\Support\Facades\Route;

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\TotalCountController;
use App\Http\Controllers\FaqController;
use App\Http\Controllers\QuizController;
use App\Http\Controllers\QuizFormFieldController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});*/



/* Route::get('users/export/', 'ExprotController@exportUsers')->name('users.export_mapping');
Route::get('categories/export/', 'ExportController@exportCategories')->name('categories.export_mapping');
Route::get('articles/export/', 'ExportController@exportArticles')->name('articles.export_mapping'); */


Route::post('login', [AuthController::class, 'index']);

Route::get('category-list', [CategoryController::class, 'categoryList']);
Route::get('category-article-list', [CategoryController::class, 'categoryArticleList']);

Route::get('article/category/{slug}', [ArticleController::class, 'articleCategory']);
Route::get('article-details/{slug}', [ArticleController::class, 'articleDetails']);
Route::get('article-list', [ArticleController::class, 'articleList']);
Route::get('article/search/{any}',[ArticleController::class, 'articleSearch']);

Route::get('faq-list',[FaqController::class, 'faqList']);
Route::get('faqs/{any}',[FaqController::class, 'show']);


Route::get('quiz-list',[QuizController::class, 'getQuizList']);
Route::get('quiz-form/field-list/{id}',[QuizFormFieldController::class, 'getQuizFieldListFromQuizForm']);

Route::get('front-page-config', [PageController::class, 'index']);

Route::group(['middleware' => 'auth:api'], function () {
    
    Route::get('articles', [ArticleController::class, 'index']);
    Route::post('articles', [ArticleController::class, 'store']);
    Route::get('articles/{article}', [ArticleController::class, 'show']);
    Route::delete('articles/{article}', [ArticleController::class, 'destroy']);
    Route::post('save-file', [ArticleController::class, 'saveFiles']);
    Route::post('delete-file', [ArticleController::class, 'deleteFiles']);
    Route::get('latest-article-list', [ArticleController::class, 'articleList']);
    Route::post('article/update-data', [ArticleController::class, 'update']);

    Route::get('users', [UserController::class, 'index']);
    Route::post('users', [UserController::class, 'store']);
    Route::get('users/{users}', [UserController::class, 'show']);
    Route::put('users/{users}', [UserController::class, 'update']);
    Route::delete('users/{users}', [UserController::class, 'destroy']);
    Route::post('user/update-password', [UserController::class,'changePassword']);
    Route::post('user/username', [UserController::class, 'checkUserNameExist']);

    Route::get('categories', [CategoryController::class, 'index']);
    Route::post('categories', [CategoryController::class, 'store']);
    Route::get('categories/{categories}', [CategoryController::class, 'show']);
    Route::put('categories/{categories}', [CategoryController::class, 'update']);
    Route::delete('categories/{categories}', [CategoryController::class, 'destroy']);
    Route::post('category/name', [CategoryController::class, 'checkCategoryNameExist']);
    Route::post('category/update-data', [CategoryController::class, 'update']);
    Route::post('category-list-for-update', [CategoryController::class, 'getCategoryForEdit']);

    Route::get('pages', [PageController::class, 'index']);
    Route::post('pages', [PageController::class, 'store']);
    Route::get('pages/{pages}', [PageController::class, 'show']);
    Route::put('pages/{pages}', [PageController::class, 'update']);
    Route::delete('pages/{pages}', [PageController::class, 'destroy']);
    Route::post('pages/update-data', [PageController::class, 'update']);

    Route::get('roles', [RoleController::class, 'index']);
    Route::post('roles', [RoleController::class, 'store']);
    Route::get('roles/{roles}', [RoleController::class, 'show']);
    Route::put('roles/{roles}', [RoleController::class, 'update']);
    Route::delete('roles/{roles}', [RoleController::class, 'destroy']);
    Route::post('role/name', [RoleController::class, 'checkRoleNameExist']);

    Route::apiResource('permissions', PermissionController::class);

    Route::get('faqs', [FaqController::class, 'index']);
    Route::post('faqs', [FaqController::class, 'store']);
    Route::get('faqs/{faqs}', [FaqController::class, 'show']);
    Route::put('faqs/{faqs}', [FaqController::class, 'update']);
    Route::delete('faqs/{faqs}', [FaqController::class, 'destroy']);

    Route::apiResource('quiz-forms', QuizFormController::class);
    
    Route::get('quizzes', [QuizController::class, 'index']);
    Route::post('quizzes', [QuizController::class, 'store']);
    Route::get('quizzes/{quizzes}', [QuizController::class, 'show']);
    Route::put('quizzes/{quizzes}', [QuizController::class, 'update']);
    Route::delete('quizzes/{quizzes}', [QuizController::class, 'destroy']);

    Route::get('quiz-form-fields', [QuizFormFieldController::class, 'index']);
    Route::post('quiz-form-fields', [QuizFormFieldController::class, 'store']);
    Route::get('quiz-form-fields/{quiz-form-fields}', [QuizFormFieldController::class, 'show']);
    Route::put('quiz-form-fields/{quiz-form-fields}', [QuizFormFieldController::class, 'update']);
    Route::delete('quiz-form-fields/{quiz-form-fields}', [QuizFormFieldController::class, 'destroy']);

    Route::post('total-count-data', [TotalCountController::class, 'totalCount']);

    Route::post('logout', [AuthController::class, 'logout']);
});

