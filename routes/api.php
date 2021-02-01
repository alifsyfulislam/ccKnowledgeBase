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

//Route::get('users/export/', function (){
//    return Excel::download(new UsersExport, 'users.xlsx');
//});

Route::get('users/export/', 'Api\ExportController@exportUsers')->name('users.export_mapping');
Route::get('categories/export/', 'Api\ExportController@exportCategories')->name('categories.export_mapping');
Route::get('articles/export/', 'Api\ExportController@exportArticles')->name('articles.export_mapping');


Route::post('login', 'Api\AuthController');
Route::get('category-list','Api\CategoryController@categoryList');
Route::get('category-article-list', 'Api\CategoryController@categoryArticleList');
Route::get('article/category/{slug}','Api\ArticleController@articleCategory');
Route::get('article-details/{slug}', 'Api\ArticleController@articleDetails');

Route::get('article-list', 'Api\ArticleController@articleList');

Route::get('article/search/{any}','Api\ArticleController@articleSearch');
Route::get('faq/search/{any}','Api\FaqController@faqSearch');

Route::get('faq-list','Api\FaqController@faqList');

Route::get('faqs/{any}','Api\FaqController@show');


Route::get('quiz-list','Api\QuizController@getQuizList');

Route::get('front-page-config', 'Api\PageController@index');

Route::get('quiz-form/field-list/{id}','Api\QuizFormFieldController@getQuizFieldListFromQuizForm');



Route::group(['prefix' => 'admin', 'namespace' => 'Api', 'middleware' => 'auth:api'], function () {

    Route::post('logout', 'AuthController@logout');

    Route::post('save-file', 'ArticleController@saveFiles');
    Route::post('delete-file', 'ArticleController@deleteFiles');
    Route::post('user/update-password', 'UserController@changePassword');

    Route::post('user/username', 'UserController@checkUserNameExist');
    Route::post('user/email', 'UserController@checkUserEmailExist');


    Route::post('category/name', 'CategoryController@checkCategoryNameExist');
    Route::post('role/name', 'RoleController@checkRoleNameExist');


    Route::get('latest-article-list', 'ArticleController@articleList');
    Route::post('change-article-status', 'ArticleController@changeArticleStatus');

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
    Route::post('change-faq-status', 'FaqController@changeFAQStatus');

    Route::apiResource('quiz-forms','QuizFormController');
    Route::apiResource('quiz-form-fields','QuizFormFieldController');
    Route::apiResource('quizzes','QuizController');

    Route::post('total-count-data', 'TotalCountController@totalCount');
});


