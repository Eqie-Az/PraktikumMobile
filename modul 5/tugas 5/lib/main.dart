import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicPlayerPage(),
    );
  }
}

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // background utama
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),
            const Center(
              child: Text(
                'Sedang memutar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            // Spacer di atas agar card berada di tengah layar
            const Spacer(),

            // Card persegi panjang 
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 120, // tinggi card — ubah kalau mau lebih kecil/besar
              decoration: BoxDecoration(
                color: const Color(0xFF232326), // abu gelap yang kontras
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 16),

                  // Icon CD 
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF7F98A1), // warna CD
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Judul & Artis
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Judul Lagu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Rifqi Azhar Raditya',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Icon LOVE 
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.redAccent,
                      iconSize: 28,
                    ),
                  ),
                ],
              ),
            ),

            // Spacer bawah untuk memastikan card tetap di tengah vertikal
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
