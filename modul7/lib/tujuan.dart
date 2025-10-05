import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text("Ini Halaman Tujuan"),
        backgroundColor: Colors.red[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Untuk berpindah ke halaman baru, gunakan Navigator.push(). "
                "Metode push() akan menambahkan route baru ke dalam stack yang dikelola oleh Navigator. "
                "Untuk menutup halaman kedua dan kembali ke halaman pertama, gunakan Navigator.pop().",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // 🔹 Gambar pantai
              Image.network(
                "https://img.icons8.com/color/200/000000/beach.png",
                width: 120,
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("< Kembali ke home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
