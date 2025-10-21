import 'package:flutter/material.dart';
import '../viewmodel/movie_viewmodel.dart';
import '../model/movie.dart';
import 'detailmovie.dart';
import 'listmovie.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieViewModel viewModel = MovieViewModel();
  int _selectedIndex = 0;

  String selectedCategory = "All";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      const ListMoviePage(),
      const AboutPage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Movie Info 🎬"),
        centerTitle: true,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orangeAccent,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Daftar"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Tentang"),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return FutureBuilder<List<Movie>>(
      future: viewModel.fetchMovies(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data!;
        final categories = ["All", "Action", "Drama", "Sci-Fi", "Animation", "Adventure"];

        // Filter dan pencarian
        final filtered = movies.where((m) {
          final categoryMatch = selectedCategory == "All" || m.category == selectedCategory;
          final searchMatch = m.title.toLowerCase().contains(searchQuery.toLowerCase());
          return categoryMatch && searchMatch;
        }).toList();

        final popular = filtered.where((m) => m.isPopular).toList();
        final latest = filtered.where((m) => !m.isPopular).toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang 🎥",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 🔍 Search bar
              TextField(
                onChanged: (val) {
                  setState(() => searchQuery = val);
                },
                decoration: InputDecoration(
                  hintText: "Cari film kesukaanmu...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              const Text("Kategori", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final c = categories[index];
                    final selected = c == selectedCategory;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(c),
                        selected: selected,
                        selectedColor: Colors.orangeAccent,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = c;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Text("Film Populer", style: TextStyle(fontWeight: FontWeight.bold)),

              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popular.length,
                  itemBuilder: (context, index) {
                    final movie = popular[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DetailMoviePage(movie: movie)),
                        );
                      },
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                movie.posterPath,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(Icons.movie, size: 80),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),
              const Text("Film Terbaru", style: TextStyle(fontWeight: FontWeight.bold)),

              ListView.builder(
                itemCount: latest.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = latest[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.posterPath,
                          width: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailMoviePage(movie: movie)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text("Lihat"),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
