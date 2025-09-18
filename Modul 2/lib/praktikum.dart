import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Row and Collumn',
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Row and Collumn"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KotakBiruJempol(),
            SizedBox(height: 20),
            KotakBiruJempol(),
            SizedBox(height: 20),
            KotakBiruJempol(),
            
          ],
        ),
      ),
    ),
  );
}
}

class KotakBiruJempol extends StatelessWidget {
  const KotakBiruJempol({super.key});
  @override
  Widget build(BuildContext context){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.thumb_up,
        color: Colors.white,
        size: 40,
      ),
    
    );
  }
}