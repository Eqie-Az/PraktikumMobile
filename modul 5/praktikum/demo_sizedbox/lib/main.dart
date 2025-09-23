import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

Container kotakUji(Color warna){
  return Container(
    height: 75,
    width: 75,
    color: warna,
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contoh SizedBox',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Contoh SizedBox'),
        ),
        body: Center(
          child: Row (
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kotakUji(Colors.amber),
              const Spacer(flex: 1),
              kotakUji(Colors.green),
              const Spacer(flex: 2),
              kotakUji(Colors.blue),
            ],
          )
        ),
      ),
    );
  }
}
