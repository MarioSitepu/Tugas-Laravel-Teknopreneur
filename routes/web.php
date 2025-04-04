<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PengurusController;

Route::get('/', fn() => redirect('/pengurus'));

Route::get('/pengurus', [PengurusController::class, 'index']);
Route::get('/pengurus/create', [PengurusController::class, 'create']);
Route::post('/pengurus', [PengurusController::class, 'store']);
Route::get('/pengurus/{id}/edit', [PengurusController::class, 'edit']);
Route::put('/pengurus/{id}', [PengurusController::class, 'update']);
Route::delete('/pengurus/{id}', [PengurusController::class, 'destroy']);

Route::view('/info', 'info');
Route::view('/deskripsi', 'deskripsi');
Route::view('/add', 'add');
