<!DOCTYPE html>
<html>
<head>
    <title>Edit Pengurus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4 text-center">Edit Data Pengurus</h2>

    <div class="card shadow-sm">
        <div class="card-body">
            <form action="/pengurus/{{ $pengurus->id }}" method="POST">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label for="nama" class="form-label">Nama</label>
                    <input type="text" name="nama" id="nama" class="form-control" value="{{ $pengurus->nama }}" required>
                </div>

                <div class="mb-3">
                    <label for="divisi" class="form-label">Divisi</label>
                    <input type="text" name="divisi" id="divisi" class="form-control" value="{{ $pengurus->divisi }}" required>
                </div>

                <div class="mb-3">
                    <label for="jabatan" class="form-label">Jabatan</label>
                    <input type="text" name="jabatan" id="jabatan" class="form-control" value="{{ $pengurus->jabatan }}" required>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="/pengurus" class="btn btn-secondary">Batal</a>
                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
