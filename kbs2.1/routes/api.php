<?php

use App\Http\Controllers\FaqController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\QuizFormController;
use App\Http\Controllers\QuizFormFieldController;
use App\Http\Controllers\TotalCountController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ArticleController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\QuizController;
use App\Http\Controllers\RoleController;

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

// Route::prefix('admin')->middleware('auth:api')->group(function() {
Route::group(['middleware' => 'auth:api'], function () {
    
    Route::apiResource('articles', ArticleController::class, ['except' => ['update']]);
    Route::post('save-file', [ArticleController::class, 'saveFiles']);
    Route::post('delete-file', [ArticleController::class, 'deleteFiles']);
    Route::get('latest-article-list', [ArticleController::class, 'articleList']);
    Route::post('article/update-data', [ArticleController::class, 'update']);

    Route::apiResource('users', UserController::class);
    Route::post('user/update-password', [UserController::class,'changePassword']);
    Route::post('user/username', [UserController::class, 'checkUserNameExist']);

    Route::apiResource('categories', CategoryController::class, ['except' => ['update']]);
    Route::post('category/name', [CategoryController::class, 'checkCategoryNameExist']);
    Route::post('category/update-data', [CategoryController::class, 'update']);
    Route::post('category-list-for-update', [CategoryController::class, 'getCategoryForEdit']);

    Route::apiResource('roles',RoleController::class);
    Route::post('role/name', [RoleController::class, 'checkRoleNameExist']);

    Route::apiResource('permissions', PermissionController::class);

    
    Route::apiResource('pages', PageController::class, ['except' => ['update']]);
    Route::post('pages/update-data', [PageController::class, 'update']);

    Route::apiResource('faqs', FaqController::class);

    Route::apiResource('quiz-forms', QuizFormController::class);
    Route::apiResource('quiz-form-fields', QuizFormFieldController::class);
    Route::apiResource('quizzes', QuizController::class);

    Route::post('total-count-data', [TotalCountController::class, 'totalCount']);

    Route::post('logout', [AuthController::class, 'logout']);
});

