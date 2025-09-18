import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(title: const Text("Row and Column")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  KotakBiruJempol(color: Color.fromARGB(255, 216, 105, 142), label: "Love 1"),
                  SizedBox(width: 20),
                  KotakBiruJempol(color: Color.fromARGB(255, 238, 170, 67), label: "Love 2"),
                ],
              ),
              SizedBox(height: 20), // jarak antar baris
              // baris kedua
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  KotakBiruJempol(color: Color.fromARGB(255, 83, 6, 96), label: "Love 3"),
                  SizedBox(width: 20),
                  KotakBiruJempol(color: Color.fromARGB(255, 0, 0, 0), label: "Love 4"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KotakBiruJempol extends StatelessWidget {
  final Color color;
  final String label;

  const KotakBiruJempol({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120, 
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}