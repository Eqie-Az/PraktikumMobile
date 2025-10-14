import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import '../viewmodel/tasbih_controller.dart';
import 'package:get/get.dart';

// class Home extends StatelessWidget widget
class Home extends StatelessWidget {
  // Constructor (DIJAGA TETAP CONST UNTUK PERFORMANCE)
  const Home({super.key});
  
  // !!! BARIS INI DIHAPUS DARI SINI:
  // final TasbihController controller = Get.put(TasbihController()); 

  @override
  // build method
  Widget build(BuildContext context) {
    // Pindahkan inisialisasi controller ke dalam method build.
    // Get.put() akan memastikan controller tersedia untuk seluruh aplikasi.
    // Jika sudah ada, GetX akan mengembalikannya, tidak membuat yang baru.
    final TasbihController controller = Get.put(TasbihController());

    // Return Scaffold
    return Scaffold(
      // backgroundColor property
      backgroundColor: const Color.fromARGB(255, 119, 210, 145),
      // body property
      body: SafeArea(
        // child property
        child: Center(
          // child property
          child: Column(
            // mainAxisAlignment property
            mainAxisAlignment: MainAxisAlignment.center,
            // children property
            children: [
              // 1. TEXT COUNTER (DIBUNGKUS OBX)
              Obx(
                () => Text(
                  // Menampilkan nilai counter dari controller (dibulatkan)
                  '${controller.counter.value.round()}',
                  // style property
                  style: const TextStyle(fontSize: 250),
                ),
              ),
              // 2. PROGRESS BAR (DIBUNGKUS OBX)
              Padding(
                // padding property
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                // child property
                child: Obx(
                  () => LinearProgressIndicator(
                    // Nilai progress perlu dibagi 100 karena LinearProgressIndicator 
                    // mengharapkan nilai antara 0.0 sampai 1.0.
                    value: controller.progress.value / 100,
                    // backgroundColor property
                    backgroundColor: Colors.white54,
                    // color property
                    color: Colors.amberAccent.shade400,
                    // minHeight property
                    minHeight: 15,
                    // borderRadius property
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // SizedBox widget
              const SizedBox(height: 75),
              // 3. TOMBOL FINGERPRINT (DIHUBUNGKAN KE incrementCounter)
              // ClipRRect widget
              ClipRRect(
                // borderRadius property
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                // child property (InkWell)
                child: InkWell(
                  // onTap callback: Memanggil incrementCounter() dari controller
                  onTap: controller.incrementCounter,
                  // child property (Container)
                  child: Container(
                    // Agar area sentuh lebih nyaman, kita tambahkan padding di sini.
                    padding: const EdgeInsets.all(30),
                    // decoration property
                    decoration: const BoxDecoration(color: Colors.white),
                    // child property (Icon)
                    child: const Icon(
                      Icons.fingerprint,
                      // size property
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // 4. FLOATING ACTION BUTTON / TOMBOL RESET 
      floatingActionButton: FloatingActionButton(
        // onPressed callback: Memanggil resetCounter() dari controller
        onPressed: controller.resetCounter,
        // backgroundColor property
        backgroundColor: Colors.white,
        // child property (Icon)
        child: const Icon(
          Icons.refresh_outlined,
          // color property
          color: Colors.black,
        ),
      ),
    );
  }
}
