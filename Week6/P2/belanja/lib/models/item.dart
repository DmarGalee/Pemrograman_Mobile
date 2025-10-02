import 'package:flutter/material.dart';
// Anggap ini adalah halaman yang menampilkan daftar item.

// >>> KELAS MODEL DITARUH DI SINI (Di luar class widget) <<<
class Item {
  String? name;
  int? price;

  Item({this.name, this.price});
}

class DaftarItemPage extends StatelessWidget {
  final List<Item> itemData = [
    Item(name: 'Pensil 2B', price: 2000),
    Item(name: 'Buku Catatan', price: 10000),
    Item(name: 'Penghapus', price: 500),
    Item(name: 'Meja Lipat', price: 150000),
  ];

  DaftarItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Barang')),
      body: ListView.builder(
        itemCount: itemData.length, // Gunakan panjang itemData
        itemBuilder: (context, index) {
          final item = itemData[index]; // Ambil objek Item saat ini

          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/item', arguments: item);
              print('Menekan item: ${item.name}');
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.inventory),
                // Tampilkan data dari objek item
                title: Text(item.name ?? 'Item Tanpa Nama'),
                subtitle: Text('Harga: Rp${item.price ?? 0}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
