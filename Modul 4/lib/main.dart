import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemutar Musik',
      theme: ThemeData.dark(), 
      home: const MusicPlayer(),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemutar Musik"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Pemutar Musik',
          style: TextStyle(fontSize: 40),
        ),
      ),
      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20), 
        color: Colors.black54, 
        child: Row(
          children: [
            
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.shuffle, color: Colors.white, size: 35),
                onPressed: () {},
              ),
            ),
            // Previous
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.skip_previous, color: Colors.white, size: 35),
                onPressed: () {},
              ),
            ),
            // Play -> gunakan Flexible flex:2
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 75),
                onPressed: () {},
              ),
            ),
           
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.skip_next, color: Colors.white, size: 35),
                onPressed: () {},
              ),
            ),
            
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.repeat, color: Colors.white, size: 35),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}