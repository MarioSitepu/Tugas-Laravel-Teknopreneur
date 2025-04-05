<?php

public function up(): void
{
    Schema::create('pengurus', function (Blueprint $table) {
        $table->id();
        $table->string('nama');
        $table->string('divisi');
        $table->string('jabatan');
        $table->timestamps();
    });
}

public function down(): void
{
    Schema::dropIfExists('pengurus');
}
