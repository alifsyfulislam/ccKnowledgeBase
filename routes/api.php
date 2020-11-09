<?php

use Illuminate\Http\Request;

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

Route::middleware(['auth:api'])->group(function () {

    Route::apiResource('users','Api\UserController');
    Route::apiResource('roles','Api\RoleController');
    Route::apiResource('permissions', 'Api\PermissionController');
    Route::apiResource('categories','Api\CategoryController');
    Route::apiResource('articles','Api\ArticleController');
    Route::apiResource('quiz-forms','Api\QuizFormController');


});


