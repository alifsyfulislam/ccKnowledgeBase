<?php

use App\Http\Controllers\ArticleController;
use App\Http\Controllers\TotalCountController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\FaqController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\QuizController;
use App\Http\Controllers\QuizFormController;
use App\Http\Controllers\QuizFormFieldController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\PermissionController;

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
Route::get('category-article-list', [CategoryController::class, 'categoryArticleList']);

Route::get('article-details/{slug}', [ArticleController::class, 'articleDetails']);
Route::get('article-list', [ArticleController::class, 'articleList']);



Route::middleware('auth:api')->group(function(){

    Route::apiResource('articles', ArticleController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('faqs', FaqController::class);
    Route::apiResource('users', UserController::class);
    Route::apiResource('roles', RoleController::class);
    Route::apiResource('quizzes', QuizController::class);
    Route::apiResource('quiz-forms', QuizFormController::class);
    Route::apiResource('quizzes', QuizFormFieldController::class);
    Route::apiResource('pages', PageController::class);
    Route::apiResource('permissions', PermissionController::class);

    Route::post('category/name', [CategoryController::class, 'checkCategoryNameExist']);
    Route::post('category/update-data', [CategoryController::class, 'update']);
    Route::post('category-list-for-update', [CategoryController::class, 'getCategoryForEdit']);

    Route::post('article/update-data', [ArticleController::class, 'update']);
    Route::post('save-file', [ArticleController::class, 'saveFiles']);
    Route::post('delete-file', [ArticleController::class, 'deleteFiles']);
    Route::get('latest-article-list', [ArticleController::class, 'articleList']);

    Route::post('pages/update-data', [PageController::class, 'update']);

    Route::post('role/name', [RoleController::class, 'checkRoleNameExist']);

    Route::post('user/update-password', [UserController::class,'changePassword']);
    Route::post('user/username', [UserController::class, 'checkUserNameExist']);

    Route::post('total-count-data', [TotalCountController::class, 'totalCount']);
    Route::post('logout', [UserController::class, 'logout']);

});

Route::post('/login', AuthController::class);

