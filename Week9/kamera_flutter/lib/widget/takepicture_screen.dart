import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io'; // Diperlukan untuk kelas File di DisplayPictureScreen

// Variabel global untuk menyimpan daftar kamera
late List<CameraDescription> cameras;

// Fungsi utama aplikasi, diubah menjadi async
Future<void> main() async {
  // 1. Inisialisasi binding Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Dapatkan daftar kamera yang tersedia
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error getting cameras: ${e.code}\n${e.description}');
    return;
  }

  // 3. Jalankan aplikasi
  runApp(
    MaterialApp(
      // Menggunakan tema gelap
      theme: ThemeData.dark(),
      // Menghapus banner debug
      debugShowCheckedModeBanner: false,
      // Menggunakan TakePictureScreen sebagai halaman utama
      home: TakePictureScreen(
        // Meneruskan kamera pertama
        camera: cameras.first,
      ),
    ),
  );
}

// =========================================================================
// 1. LAYAR UNTUK MENGAMBIL GAMBAR (TAKEPICTURESCREEN)
// =========================================================================

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    // Inisialisasi CameraController
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium, // Menggunakan resolusi sedang
    );

    // Memulai proses inisialisasi controller
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Membuang controller saat widget dibuang untuk menghindari kebocoran memori
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture - NIM Anda')),

      // Menampilkan preview kamera setelah inisialisasi selesai
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika Controller sudah siap, tampilkan preview dengan AspectRatio
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            );
          } else if (snapshot.hasError) {
            // Tampilkan pesan error jika inisialisasi gagal
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Tampilkan loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      // Tombol untuk mengambil gambar
      floatingActionButton: FloatingActionButton(
        // Aktifkan tombol hanya jika controller sudah siap
        onPressed: (_controller.value.isInitialized)
            ? () async {
                try {
                  // Pastikan bahwa kamera telah diinisialisasi
                  await _initializeControllerFuture;

                  // Ambil gambar
                  final image = await _controller.takePicture();

                  if (!context.mounted) return;

                  // Navigasi ke layar DisplayPictureScreen untuk menampilkan hasil foto
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imagePath: image.path, // Meneruskan path file gambar
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              }
            : null, // Tombol dinonaktifkan jika belum siap
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// =========================================================================
// 2. LAYAR UNTUK MENAMPILKAN HASIL FOTO (DISPLAYPICTURESCREEN)
// =========================================================================

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - NIM Anda')),

      // Menampilkan gambar dari file yang disimpan
      body: Center(
        child: Image.file(
          File(imagePath), // Membuat objek File dari jalur yang diberikan
        ),
      ),
    );
  }
}
