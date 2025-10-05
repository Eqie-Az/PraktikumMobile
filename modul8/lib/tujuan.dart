import 'screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Tujuan extends StatelessWidget {
  const Tujuan({super.key});
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // Ambil data yang dikirim dari halaman Home
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    // Tampilan halaman detail game
    return Scaffold(
      backgroundColor: const Color(0xFFFF94A29),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // ======== BAGIAN DETAIL GAME ========
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4F8FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          args.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        args.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        args.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 47, 72),
                        ),
                      ),
                    ],
                  ),
                ),

                // ======== TOMBOL KEMBALI KE GAME ========
                const SizedBox(height: 25),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0E81C9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 15,
                              color: Color(0xFFFFF4F8FB),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Kembali ke game',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFFFF4F8FB),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
