// 1. IMPORTS WAJIB
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// ====================================================================
// MODEL CLASS (Post)
// ====================================================================
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'] ?? 1,
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.now(),
    );
  }
}

// ====================================================================
// FUNGSI UTAMA (main) & WIDGET APLIKASI ROOT (MyApp)
// ====================================================================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo[900],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.lightBlueAccent,
        ),
        scaffoldBackgroundColor: Colors.blueGrey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo[900],
          elevation: 4,
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ====================================================================
// WIDGET HOME PAGE (StatefulWidget)
// ====================================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Post? createdPost;

  // ------------------------------------------------------------------
  // METODE HTTP POST (CREATE)
  // ------------------------------------------------------------------
  Future<void> createPost(String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // ... (Logika createPost sama seperti sebelumnya) ...
    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
      );

      if (!mounted) return;

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          createdPost = Post.fromJson(data);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post berhasil ditambahkan!')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal menambah post')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // ------------------------------------------------------------------
  // METODE HTTP PUT (UPDATE)
  // ------------------------------------------------------------------
  Future<void> updatePost(int id, String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    // ... (Logika updatePost sama seperti sebelumnya) ...
    try {
      final response = await http.put(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'id': id,
          'title': title,
          'body': body,
          'userId': createdPost?.userId ?? 1,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          createdPost = Post(
            id: createdPost!.id,
            userId: createdPost!.userId,
            title: data['title'],
            body: data['body'],
            createdAt: createdPost!.createdAt,
          );
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post berhasil diupdate!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Gagal mengupdate post')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // ------------------------------------------------------------------
  // q. METODE HTTP DELETE (DELETE)
  // ------------------------------------------------------------------
  Future<void> deletePost(int id) async {
    // Gunakan ID dari post yang dikirim
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');

    try {
      final response = await http.delete(
        url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
      );

      if (!mounted) return;

      // Status code 200 OK menandakan delete berhasil
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post berhasil dihapus!'),
            backgroundColor: Colors.green,
          ),
        );
        // Atur state menjadi null untuk mengembalikan UI ke keadaan semula
        setState(() {
          createdPost = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menghapus post'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // ------------------------------------------------------------------
  // DIALOG UNTUK CREATE POST
  // ------------------------------------------------------------------
  void showAddPostDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Pekerjaan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final finalTitle = titleController.text.trim();
              final finalBody = bodyController.text.trim();

              if (finalTitle.isNotEmpty && finalBody.isNotEmpty) {
                createPost(finalTitle, finalBody);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nama dan Pekerjaan harus diisi'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[900],
            ),
            child: const Text('Simpan', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // DIALOG UNTUK UPDATE POST
  // ------------------------------------------------------------------
  void showUpdatePostDialog(Post currentPost) {
    final titleController = TextEditingController(text: currentPost.title);
    final bodyController = TextEditingController(text: currentPost.body);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: 'Pekerjaan'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final finalUpdatedTitle = titleController.text.trim();
              final finalUpdatedBody = bodyController.text.trim();

              if (finalUpdatedTitle.isNotEmpty && finalUpdatedBody.isNotEmpty) {
                updatePost(currentPost.id, finalUpdatedTitle, finalUpdatedBody);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nama dan Pekerjaan harus diisi!'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[900],
            ),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // KONFIRMASI DIALOG UNTUK DELETE
  // ------------------------------------------------------------------
  void showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus post ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Hanya tutup dialog
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog konfirmasi
              deletePost(id); // Panggil fungsi delete
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Warna merah menandakan aksi bahaya
            ),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ====================================================================
  // WIDGET build()
  // ====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo CRUD client-server')),

      // --- Tampilan Conditional (Read/Data View) ---
      body: Center(
        child: createdPost == null
            ? Text(
                'Demo CRUD client-server di Flutter',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo[900],
                ),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.indigo.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row untuk Judul + PopupMenuButton
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    createdPost!.title,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                // Tombol Menu (Update dan Delete)
                                PopupMenuButton<String>(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white70,
                                  ),
                                  itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'update',
                                      child: Text('Update'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                  // s. Logika onSelected yang diperbarui
                                  onSelected: (value) {
                                    if (value == 'update' &&
                                        createdPost != null) {
                                      showUpdatePostDialog(createdPost!);
                                    } else if (value == 'delete' &&
                                        createdPost != null) {
                                      // Panggil dialog konfirmasi delete
                                      showDeleteConfirmationDialog(
                                        createdPost!.id,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Isi (Body) Post
                            Text(
                              createdPost!.body,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // ID Post
                            Text(
                              'Id: ${createdPost!.id}',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // User ID Post
                            Text(
                              'UserId: ${createdPost!.userId}',
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.white54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Tanggal Dibuat
                            Text(
                              DateFormat(
                                "dd MMMM yyyy, HH.mm 'WIB'",
                              ).format(createdPost!.createdAt),
                              style: GoogleFonts.openSans(
                                color: Colors.white54,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),

      // FloatingActionButton untuk CREATE
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPostDialog,
        backgroundColor: Colors.indigo[900],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
    );
  }
}
