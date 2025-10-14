import 'package:get/get.dart';

// Deklarasi class TasbihController yang meng-extends GetxController
class TasbihController extends GetxController {
  // Variabel observable (RxDouble) untuk menghitung tasbih
  var counter = 0.0.obs;

  // Variabel observable (RxDouble) untuk menyimpan nilai progress (%)
  var progress = 0.0.obs;

  // Nilai maksimum hitungan, diatur sebagai konstanta (final)
  final double maxCount = 33;

  // Method untuk menambah (increment) nilai counter
  void incrementCounter() {
    // Cek apakah counter masih kurang dari nilai maksimum
    if (counter.value < maxCount) {
      // Tambah nilai counter sebanyak 1
      counter.value++;
      // Hitung dan update nilai progress
      progress.value = (counter.value / maxCount) * 100;
    }
  }

  // Method untuk mereset nilai counter dan progress
  void resetCounter() {
    // Reset nilai counter menjadi 0
    counter.value = 0;
    // Reset nilai progress menjadi 0
    progress.value = 0;
  }
}