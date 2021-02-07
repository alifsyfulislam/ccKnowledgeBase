<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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



Route::get('users/export/', 'ExportController@exportUsers')->name('users.export_mapping');
Route::get('categories/export/', 'ExportController@exportCategories')->name('categories.export_mapping');
Route::get('articles/export/', 'ExportController@exportArticles')->name('articles.export_mapping');


Route::post('login', 'AuthController');
Route::get('category-list','CategoryController@categoryList');
Route::get('category-article-list', 'CategoryController@categoryArticleList');
Route::get('article/category/{slug}','ArticleController@articleCategory');
Route::get('article-details/{slug}', 'ArticleController@articleDetails');

Route::get('article-list', 'ArticleController@articleList');

Route::get('article/search/{any}','ArticleController@articleSearch');

Route::get('faq-list','FaqController@faqList');

Route::get('faqs/{any}','FaqController@show');


Route::get('quiz-list','QuizController@getQuizList');

Route::get('front-page-config', 'PageController@index');

Route::get('quiz-form/field-list/{id}','QuizFormFieldController@getQuizFieldListFromQuizForm');



Route::group(['prefix' => 'admin', 'namespace' => 'Api', 'middleware' => 'auth:api'], function () {

    Route::post('save-file', 'ArticleController@saveFiles');
    Route::post('delete-file', 'ArticleController@deleteFiles');
    Route::post('user/update-password', 'UserController@changePassword');

    Route::post('user/username', 'UserController@checkUserNameExist');
    Route::post('user/email', 'UserController@checkUserEmailExist');


    Route::post('category/name', 'CategoryController@checkCategoryNameExist');
    Route::post('role/name', 'RoleController@checkRoleNameExist');


    Route::get('latest-article-list', 'ArticleController@articleList');

    Route::post('logout', 'AuthController@logout');

    Route::apiResource('users','UserController');
    Route::apiResource('roles','RoleController');
    Route::apiResource('permissions', 'PermissionController');

    Route::apiResource('categories','CategoryController', ['except' => ['update']]);

    Route::post('category/update-data', 'CategoryController@update');

    Route::post('category-list-for-update', 'CategoryController@getCategoryForEdit');

    Route::apiResource('articles','ArticleController', ['except' => ['update']]);

    Route::post('article/update-data', 'ArticleController@update');

    Route::apiResource('pages','PageController', ['except' => ['update']]);

    Route::post('pages/update-data', 'PageController@update');

    Route::apiResource('faqs','FaqController');
    Route::apiResource('quiz-forms','QuizFormController');
    Route::apiResource('quiz-form-fields','QuizFormFieldController');
    Route::apiResource('quizzes','QuizController');

    Route::post('total-count-data', 'TotalCountController@totalCount');
});

