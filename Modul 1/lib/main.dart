import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});


@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Program Pertamaku"),
      ),
      body: const Center(
        child: Text(
          "Rifqi Azhar Raditya",
          style: TextStyle(fontSize: 42), textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
}