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

Route::get('faq-list','Api\FaqController@faqList');

Route::get('faqs/{any}','Api\FaqController@show');


Route::get('quiz-list','Api\QuizController@getQuizList');

Route::get('front-page-config', 'Api\PageController@index');

Route::get('quiz-form/field-list/{id}','Api\QuizFormFieldController@getQuizFieldListFromQuizForm');



Route::group(['prefix' => 'admin', 'middleware' => 'auth:api'], function () {
    Route::post('save-file', 'Api\ArticleController@saveFiles');
    Route::post('delete-file', 'Api\ArticleController@deleteFiles');
    Route::post('user/update-password', 'Api\UserController@changePassword');

    Route::post('user/username', 'Api\UserController@checkUserNameExist');
    Route::post('user/email', 'Api\UserController@checkUserEmailExist');


    Route::post('category/name', 'Api\CategoryController@checkCategoryNameExist');
    Route::post('role/name', 'Api\RoleController@checkRoleNameExist');


    Route::get('latest-article-list', 'Api\ArticleController@articleList');

    Route::post('logout', 'Api\AuthController@logout');

    Route::apiResource('users','Api\UserController');
    Route::apiResource('roles','Api\RoleController');
    Route::apiResource('permissions', 'Api\PermissionController');

    Route::apiResource('categories','Api\CategoryController', ['except' => ['update']]);

    Route::post('category/update-data', 'Api\CategoryController@update');

    Route::post('category-list-for-update', 'Api\CategoryController@getCategoryForEdit');

    Route::apiResource('articles','Api\ArticleController', ['except' => ['update']]);

    Route::post('article/update-data', 'Api\ArticleController@update');

    Route::apiResource('pages','Api\PageController', ['except' => ['update']]);

    Route::post('pages/update-data', 'Api\PageController@update');

    Route::apiResource('faqs','Api\FaqController');
    Route::apiResource('quiz-forms','Api\QuizFormController');
    Route::apiResource('quiz-form-fields','Api\QuizFormFieldController');
    Route::apiResource('quizzes','Api\QuizController');
});


