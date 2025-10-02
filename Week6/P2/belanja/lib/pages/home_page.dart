import 'package:flutter/material.dart';

class Item {
  final String name;
  final int price;

  // Gunakan 'const' dan 'required' untuk Null Safety dan konsistensi
  const Item({required this.name, required this.price});
}

class HomePage extends StatelessWidget {
  final List<Item> items = const [
    Item(name: 'Sugar', price: 5000),
    Item(name: 'Salt', price: 2000),
  ];

  @override
  Widget build(BuildContext context) {
    // KODE ANDA DITARUH DI DALAM RETURN DARI METODE BUILD INI
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Barang')),
      // BAGIAN BODY INI ADALAH TEMPAT KODE BARU ANDA BERADA
      body: Container(
        // Mulai dari 'body: Container('
        margin: const EdgeInsets.all(8),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    // Menampilkan nama di sisi kiri
                    Expanded(child: Text(item.name)),
                    // Menampilkan harga di sisi kanan
                    Expanded(
                      child: Text(
                        // Harga akan ditampilkan di kanan karena Expanded
                        item.price.toString(),
                        textAlign: TextAlign.end,
                      ), // Text
                    ), // Expanded
                  ],
                ), // Row
              ), // Container
            ); // Card
          }, // itemBuilder
        ), // ListView.builder
      ), // Container
    ); // Scaffold
  }
}
