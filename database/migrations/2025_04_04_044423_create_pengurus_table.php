public function up()
{
    Schema::create('pengurus', function (Blueprint $table) {
        $table->id();
        $table->string('nama');
        $table->string('divisi');
        $table->string('jabatan');
        $table->timestamps();
    });
}
