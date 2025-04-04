<!DOCTYPE html>
<html>
<head>
    <title>Daftar Pengurus</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h1 class="mb-4 text-center">Daftar Pengurus</h1>

    <a href="/pengurus/create" class="btn btn-primary mb-3">+ Tambah Pengurus</a>

    <table class="table table-bordered table-striped shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>No</th>
                <th>Nama</th>
                <th>Divisi</th>
                <th>Jabatan</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody>
            @foreach($pengurus as $p)
            <tr>
                <td>{{ $loop->iteration }}</td>
                <td>{{ $p->nama }}</td>
                <td>{{ $p->divisi }}</td>
                <td>{{ $p->jabatan }}</td>
                <td>
                    <a href="/pengurus/{{ $p->id }}/edit" class="btn btn-sm btn-warning">Edit</a>
                    <form action="/pengurus/{{ $p->id }}" method="POST" style="display:inline-block">
                        @csrf
                        @method('DELETE')
                        <button class="btn btn-sm btn-danger" onclick="return confirm('Hapus data ini?')">Hapus</button>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>

</body>
</html>
