import 'package:flutter/material.dart';
import 'package:game_app/model/detailgame.dart';
import 'package:readmore/readmore.dart';
import 'package:game_app/model/view/viewmodel/fetchgame.dart';  

class Detail extends StatelessWidget {
  final int gameTerpilih;
  const Detail({super.key, required this.gameTerpilih});

  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih);
    return DetailGame.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Game')),
      body: FutureBuilder<DetailGame>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final detailGame = snapshot.data!;
          final screenshots = detailGame.screenshots ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                if (detailGame.thumbnail != null)
                  Center(
                    child: Image.network(
                      detailGame.thumbnail!,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(height: 16),

                // Title
                Text(
                  detailGame.title ?? 'Tanpa Judul',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Genre dan Platform
                Text(
                  'Genre: ${detailGame.genre ?? 'Tidak tersedia'} | Platform: ${detailGame.platform ?? 'Tidak tersedia'}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Deskripsi pendek
                ReadMoreText(
                  detailGame.short_description ?? 'Tidak ada deskripsi singkat.',
                  trimLines: 2,
                  colorClickableText: Colors.blue,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Baca selengkapnya',
                  trimExpandedText: 'Tutup',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),

                // Screenshot
                if (screenshots.isNotEmpty)
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: screenshots.length,
                      itemBuilder: (context, index) {
                        final img = screenshots[index].image;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              img ?? '',
                              width: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 24),

                // Deskripsi lengkap
                const Text(
                  'Deskripsi Lengkap:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  detailGame.description ?? 'Tidak ada deskripsi tersedia.',
                ),
                const SizedBox(height: 24),

                // Minimum System Requirements
                const Text(
                  'Minimum System Requirements:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text('OS: ${detailGame.minimum_system_requirements?.os ?? 'Tidak tersedia'}'),
                Text('Processor: ${detailGame.minimum_system_requirements?.processor ?? 'Tidak tersedia'}'),
                Text('Memory: ${detailGame.minimum_system_requirements?.memory ?? 'Tidak tersedia'}'),
                Text('Graphics: ${detailGame.minimum_system_requirements?.graphics ?? 'Tidak tersedia'}'),
                Text('Storage: ${detailGame.minimum_system_requirements?.storage ?? 'Tidak tersedia'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}