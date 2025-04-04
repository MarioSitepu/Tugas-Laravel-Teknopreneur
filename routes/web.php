<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PengurusController;
use Illuminate\Support\Facades\Artisan;

// Redirect ke halaman pengurus
Route::get('/', fn() => redirect('/pengurus'));

// CRUD Pengurus
Route::get('/pengurus', [PengurusController::class, 'index']);
Route::get('/pengurus/create', [PengurusController::class, 'create']);
Route::post('/pengurus', [PengurusController::class, 'store']);
Route::get('/pengurus/{id}/edit', [PengurusController::class, 'edit']);
Route::put('/pengurus/{id}', [PengurusController::class, 'update']);
Route::delete('/pengurus/{id}', [PengurusController::class, 'destroy']);

// View statis
Route::view('/info', 'info');
Route::view('/deskripsi', 'deskripsi');
Route::view('/add', 'add');

// Route sementara untuk migrasi di Render
Route::get('/migrate', function () {
    Artisan::call('migrate', ['--force' => true]);
    return 'Migrasi selesai!';
});
