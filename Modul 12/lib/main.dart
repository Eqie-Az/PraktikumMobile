import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Import paket geolocator dan geocoding.
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

// Class MyApp menggunakan MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokasi Saya',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const LocationScreen(),
    );
  }
}

// Class LocationScreen sebagai turunan StatefulWidget
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _GeolocationScreenState();
}

// State class untuk GeolocationScreen
class _GeolocationScreenState extends State<LocationScreen> {
  // Variabel state untuk data lokasi, status loading, dan error
  String? _kecamatan;
  String? _kota;
  bool _isLoading = false;
  String? _errorMessage;

  // Fungsi _getLocation() untuk mengambil data lokasi
  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _kecamatan = null;
      _kota = null;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak aktif. Mohon aktifkan GPS.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak oleh pengguna.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen. Anda harus mengubahnya di pengaturan aplikasi.',
        );
      }

      // Menggunakan desiredAccuracy karena parameter 'settings' menyebabkan error pada IDE Anda
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _kecamatan = place.subLocality;
          _kota = place.subAdministrativeArea;
        });
      } else {
        throw Exception('Tidak dapat menemukan informasi alamat.');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method build() dengan UI yang diperbarui menggunakan Card dan ElevatedButton
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text('Lokasi Saya'),
        backgroundColor: const Color(0xFF1A237E), // Indigo 900
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 32.0,
                  horizontal: 16.0,
                ),
                child: Center(
                  child: Builder(
                    builder: (context) {
                      // 1. Tampilkan status loading
                      if (_isLoading) {
                        return const Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text(
                              'Memuat lokasi...',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      }

                      // 2. Tampilkan pesan error
                      if (_errorMessage != null) {
                        return Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        );
                      }

                      // 3. Tampilkan data lokasi
                      if (_kecamatan != null && _kota != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Keterangan Kecamatan/Kelurahan
                            Text(
                              'Kelurahan/Kecamatan: $_kecamatan',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Keterangan Kota
                            Text(
                              'Kota: $_kota',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }

                      // 4. Instruksi awal (jika data masih kosong)
                      return const Text(
                        'Tekan tombol di bawah untuk menampilkan lokasi.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ElevatedButton
            ElevatedButton(
              onPressed: _isLoading ? null : _getLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF1A237E,
                ), // Warna latar belakang Indigo 900
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5.0,
              ),
              child: Text(
                'TAMPILKAN LOKASI SAAT INI',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
