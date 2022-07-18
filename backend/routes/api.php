<?php

use Illuminate\Http\Request;
use App\Http\Controllers\DashboardIOTController;
use App\Http\Controllers\BatchController;
use App\Http\Controllers\CultureController;
use App\Http\Controllers\ParameterController;


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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


// DASHBOARDIOT ROUTES
    Route::get('/get_bar_chart', [DashboardIOTController::class, 'getBarChart']);
    Route::get('/get_parameters', [DashboardIOTController::class, 'getParameters']);
    Route::put('/edit_moisture/{batch}', [DashboardIOTController::class, 'editMoisture']);
    Route::post('/reset_moisture', [DashboardIOTController::class, 'resetMoisture']);
// DASHBOARDIOT ROUTES

// BATCH ROUTES
    Route::get('/get_batches', [BatchController::class, 'getBatches']);
    Route::post('/add_batch', [BatchController::class, 'addBatch']);
    Route::put('/edit_batch/{batch}', [BatchController::class, 'editBatch']);
    Route::delete('/delete_batch/{batch}', [BatchController::class, 'deleteBatch']);
// BATCH ROUTES

// CULTURE ROUTES
    Route::get('/get_cultures', [CultureController::class, 'getCultures']);
    Route::post('/add_culture', [CultureController::class, 'addCulture']);
    Route::put('/edit_culture/{culture}', [CultureController::class, 'editCulture']);
    Route::delete('/delete_culture/{culture}', [CultureController::class, 'deleteCulture']);
// CULTURE ROUTES

// PARAMETERS ROUTES
    Route::put('/edit_parameter/{parameter}', [ParameterController::class, 'editParameter']);
// PARAMETERS ROUTES


