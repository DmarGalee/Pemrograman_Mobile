import 'package:flutter/material.dart';
import 'widget/filter_carousel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Filter App',
      // Menggunakan tema gelap untuk kontras yang baik dengan filter
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const PhotoFilterCarousel(),
    );
  }
}
