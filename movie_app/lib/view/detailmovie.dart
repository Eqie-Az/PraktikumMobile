import 'package:flutter/material.dart';
import '../model/movie.dart';

class DetailMoviePage extends StatelessWidget {
  final Movie movie;

  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(movie.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Poster Film
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.posterPath,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 16),

            // Judul Film
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            Text(
              "Kategori: ${movie.category}",
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              "Tanggal Rilis: ${movie.releaseDate}",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const Divider(height: 30, thickness: 1),

            // Deskripsi Film (langsung pakai overview dari JSON Indonesia)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sinopsis",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              movie.overview,
              style: const TextStyle(fontSize: 16, height: 1.6),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
