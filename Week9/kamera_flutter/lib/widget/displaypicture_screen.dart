import 'package:flutter/material.dart';
import 'dart:io'; // <<< IMPORT INI DITAMBAHKAN AGAR 'File' DIKENALI

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture - NIM Anda')),

      // Gunakan Center untuk memastikan gambar berada di tengah (opsional, tapi seringkali lebih baik)
      body: Center(
        // Image.file membutuhkan objek File, yang dibuat dari imagePath
        child: Image.file(
          File(imagePath), // <<< Menggunakan kelas File dari dart:io
        ),
      ),
    );
  }
}
