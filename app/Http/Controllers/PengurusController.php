<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pengurus;

class PengurusController extends Controller
{
    // Tampilkan semua data
    public function index()
    {
        $pengurus = Pengurus::all();
        return view('pengurus.index', compact('pengurus'));
    }

    // Tampilkan form tambah
    public function create()
    {
        return view('pengurus.create');
    }

    // Simpan data baru
    public function store(Request $request)
    {
        Pengurus::create([
            'nama' => $request->nama,
            'divisi' => $request->divisi,
            'jabatan' => $request->jabatan
        ]);

        return redirect('/pengurus')->with('success', 'Data berhasil ditambahkan');
    }

    // Tampilkan form edit
    public function edit($id)
    {
        $pengurus = Pengurus::findOrFail($id);
        return view('pengurus.edit', compact('pengurus'));
    }

    // Simpan perubahan data
    public function update(Request $request, $id)
    {
        $pengurus = Pengurus::findOrFail($id);
        $pengurus->update([
            'nama' => $request->nama,
            'divisi' => $request->divisi,
            'jabatan' => $request->jabatan
        ]);

        return redirect('/pengurus')->with('success', 'Data berhasil diperbarui');
    }

    // Hapus data
    public function destroy($id)
    {
        $pengurus = Pengurus::findOrFail($id);
        $pengurus->delete();

        return redirect('/pengurus')->with('success', 'Data berhasil dihapus');
    }
}
