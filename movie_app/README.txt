Movie Info App

Deskripsi Singkat
Movie Info App adalah aplikasi Flutter sederhana yang menampilkan daftar film menggunakan data JSON lokal tanpa memerlukan koneksi internet. Aplikasi ini dibuat untuk memenuhi tugas UTS Praktikum Mobile Programming dengan tujuan memahami cara pengelolaan data lokal, navigasi antarhalaman, serta penerapan konsep MVVM (Model-View-ViewModel) pada Flutter.



Tema dan Tujuan Aplikasi
Tema aplikasi ini adalah “Informasi Film Populer dan Terbaru”.

Tujuan pengembangannya meliputi:
* Menampilkan informasi film seperti judul, poster, kategori, sinopsis, dan tanggal rilis.
* Menerapkan dasar-dasar Flutter seperti widget tree, stateful widget, dan navigasi.
* Mengelola dan menampilkan data secara dinamis dari file JSON lokal (assets/movies.json).
* Menyajikan antarmuka (UI) yang sederhana, konsisten, dan mudah digunakan



Struktur dan Fungsi Halaman
1. Home Page (lib/view/home.dart)
   Menampilkan daftar film populer dan terbaru, menyediakan fitur pencarian film serta filter kategori.
2. Daftar Film (lib/view/listmovie.dart)
   Menampilkan seluruh daftar film dalam bentuk list card yang diambil dari file JSON lokal.
3. Detail Film (lib/view/detailmovie.dart)
   Menampilkan informasi detail film, termasuk poster, kategori, tanggal rilis, dan sinopsis lengkap.
4. Tentang Aplikasi (lib/view/about.dart)
&nbsp;  Menampilkan identitas pembuat aplikasi dan deskripsi singkat mengenai tujuan pengembangan proyek.

Daftar Halaman dan Fungsinya
1. Home Page (Beranda Utama)
Menampilkan daftar film populer dan film terbaru secara terpisah. Pengguna dapat mencari film tertentu atau memfilter berdasarkan kategori.

2. Daftar Film (List Movie Page)
Menampilkan seluruh film dari file JSON dalam bentuk daftar (list card). Setiap item menampilkan gambar poster, kategori, dan deskripsi singkat.

3. Detail Film (Detail Movie Page)
Menampilkan informasi lengkap mengenai satu film, seperti poster, kategori, tanggal rilis, dan sinopsis berbahasa Indonesia. Dilengkapi tombol “Kembali ke daftar” untuk navigasi mudah.

4. Tentang Aplikasi (About Page)
Berisi informasi pembuat aplikasi, tujuan pembuatan, serta deskripsi singkat mengenai proyek ini sebagai bagian dari UTS Praktikum Mobile Programming

Cara Menjalankan Aplikasi

1. Unduh semua dependensi yang diperlukan, dependensi bisa di cek pada file pubspec.yaml. Unduh dengan cara mengetik "flutter pub get" pada terminal vscode dll
2. Jika sudah bisa langsung di run lewat main.dart atau ketik "flutter run" pada terminal vscode
