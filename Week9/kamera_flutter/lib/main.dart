import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io'; // Diperlukan untuk kelas File di DisplayPictureScreen

// Variabel global untuk menyimpan daftar kamera
late List<CameraDescription> cameras;

Future<void> main() async {
  // 1. Inisialisasi binding Flutter untuk memanggil plugin native
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Dapatkan daftar kamera yang tersedia (asinkron)
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    // Penanganan error
    print('Error getting cameras: ${e.code}\n${e.description}');
    return;
  }

  // 3. Jalankan aplikasi dengan struktur runApp yang diubah
  runApp(
    MaterialApp(
      // Menggunakan tema gelap (sesuai permintaan)
      theme: ThemeData.dark(),
      // Menghapus banner debug (sesuai permintaan)
      debugShowCheckedModeBanner: false,
      // Menggunakan TakePictureScreen sebagai halaman utama
      home: TakePictureScreen(
        // Meneruskan kamera pertama ke widget TakePictureScreen
        camera: cameras.first,
      ),
    ),
  );
}

// --- Kelas-kelas Pendukung (Ditambahkan agar kode ini berfungsi) ---

// Widget untuk mengambil gambar (TakePictureScreen)
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
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ambil Gambar - 2341720200')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (_controller.value.isInitialized)
            ? () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();

                  if (!mounted) return;
                  // Navigasi ke DisplayPictureScreen setelah mengambil gambar
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayPictureScreen(imagePath: image.path),
                    ),
                  );
                } catch (e) {
                  print('Error taking picture: $e');
                }
              }
            : null,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// Widget untuk menampilkan gambar (DisplayPictureScreen)
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('menampilkan gambar - 2341720200')),
      body: Center(child: Image.file(File(imagePath))),
    );
  }
}
