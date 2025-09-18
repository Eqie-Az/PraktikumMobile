import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alligment',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Alligment"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Malang",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  "50\u00B0C",
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    cuacaHarian(
                        day: 'Minggu',
                        icon: Icons.sunny,
                        temperature: '20\u00B0C'),
                    cuacaHarian(
                        day: 'Senin',
                        icon: Icons.cloudy_snowing,
                        temperature: '23\u00B0C'),
                    cuacaHarian(
                        day: 'Selasa',
                        icon: Icons.cloud,
                        temperature: '22\u00B0C'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class cuacaHarian extends StatelessWidget {
  final String day;
  final IconData icon;
  final String temperature;

  const cuacaHarian({
    super.key,
    required this.day,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          temperature,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}