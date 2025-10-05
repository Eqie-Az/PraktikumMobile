import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Ini Halaman Home"),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Banyak aplikasi memiliki beberapa layar untuk menampilkan informasi yang berbeda. "
                "Contohnya, ada layar produk, dan ketika pengguna mengklik produk, "
                "akan muncul layar dengan detail produk tersebut.\n\n"
                "Pertama, kita perlu membuat dua halaman atau 'routes' yang ingin kita tampilkan. "
                "Selanjutnya, gunakan Navigator.pushNamed() untuk berpindah dari halaman pertama ke halaman kedua. "
                "Terakhir, kita bisa kembali dari halaman kedua ke halaman pertama dengan Navigator.pop().",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // 🔹 Gambar rumah
              Image.network(
                "https://img.icons8.com/color/200/000000/home-page.png",
                width: 120,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tujuan');
                },
                child: const Text("Ke halaman tujuan >"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
