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

Route::post('login', 'Api\AuthController');
Route::get('category-list','Api\CategoryController@categoryList');
Route::get('category-article-list', 'Api\CategoryController@categoryArticleList');
Route::get('article/category/{id}','Api\ArticleController@articleCategory');
Route::get('article/{id}', 'Api\ArticleController@show');
Route::get('article-list', 'Api\ArticleController@articleList');
Route::get('article/search/{any}','Api\ArticleController@articleSearch');
Route::get('faqs','Api\FaqController@index');
Route::get('faqs/{any}','Api\FaqController@show');
Route::post('save-file', 'Api\ArticleController@saveFiles');


Route::group(['prefix' => 'admin', 'middleware' => 'auth:api'], function () {

    Route::apiResource('users','Api\UserController');
    Route::apiResource('roles','Api\RoleController');
    Route::apiResource('permissions', 'Api\PermissionController');
    Route::apiResource('categories','Api\CategoryController');

    Route::apiResource('articles','Api\ArticleController', ['except' => ['update']]);

    Route::post('article/update-data', 'Api\ArticleController@update');
    Route::apiResource('faqs','Api\FaqController');
    Route::apiResource('quiz-forms','Api\QuizFormController');
    Route::apiResource('quiz-form-fields','Api\QuizFormFieldController');
    Route::apiResource('quizzes','Api\QuizController');

});


