import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image/image.dart' as img;

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi kamera
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error getting cameras: ${e.code}\n${e.description}');
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TakePictureScreen(camera: cameras.first),
    ),
  );
}

// ===========================================================================
// LAYAR MENGAMBIL FOTO
// ===========================================================================

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({super.key, required this.camera});

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
      appBar: AppBar(title: const Text('Ambil Foto - Praktikum Flutter')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!mounted) return;

            // Navigasi ke layar filter carousel
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    PhotoFilterCarouselScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// ===========================================================================
// LAYAR MENAMPILKAN DAN MENERAPKAN FILTER FOTO (CAROUSEL)
// ===========================================================================

class PhotoFilterCarouselScreen extends StatefulWidget {
  final String imagePath;
  const PhotoFilterCarouselScreen({super.key, required this.imagePath});

  @override
  State<PhotoFilterCarouselScreen> createState() =>
      _PhotoFilterCarouselScreenState();
}

class _PhotoFilterCarouselScreenState extends State<PhotoFilterCarouselScreen> {
  late img.Image originalImage;
  late List<Map<String, dynamic>> filters;

  @override
  void initState() {
    super.initState();
    final imageBytes = File(widget.imagePath).readAsBytesSync();
    originalImage = img.decodeImage(imageBytes)!;

    // Daftar filter sederhana
    filters = [
      {'name': 'Normal', 'filter': (img.Image image) => image},
      {
        'name': 'GrayScale',
        'filter': (img.Image image) => img.grayscale(image),
      },
      {'name': 'Sepia', 'filter': (img.Image image) => img.sepia(image)},
      {'name': 'Invert', 'filter': (img.Image image) => img.invert(image)},
      {'name': 'Emboss', 'filter': (img.Image image) => img.emboss(image)},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Filter Foto')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: CarouselSlider.builder(
              itemCount: filters.length,
              options: CarouselOptions(
                enlargeCenterPage: true,
                height: 400,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, index, realIndex) {
                final filter = filters[index];
                final filteredImage = filter['filter'](
                  img.copyResize(originalImage, width: 400),
                );

                return Column(
                  children: [
                    Expanded(
                      child: Image.memory(
                        img.encodeJpg(filteredImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      filter['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
