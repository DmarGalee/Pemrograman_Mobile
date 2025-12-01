import 'package:flutter/material.dart';
import 'model/pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  const PizzaDetailScreen({super.key});

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  // POIN 8
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  String operationResult = '';

  // POIN 9 — dispose
  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    super.dispose();
  }

  Future<void> postPizza() async {
    HttpHelper helper = HttpHelper();

    final int pizzaId = int.tryParse(txtId.text) ?? 0;
    final String name = txtName.text.isEmpty ? 'Unknown Pizza' : txtName.text;
    final String desc = txtDescription.text.isEmpty
        ? 'No description'
        : txtDescription.text;
    final double price = double.tryParse(txtPrice.text) ?? 0.0;
    final String image = txtImageUrl.text.isEmpty ? '' : txtImageUrl.text;

    // BUAT OBJEK PIZZA LANGSUNG DENGAN CONSTRUCTOR YANG BENAR
    Pizza pizza = Pizza(
      id: pizzaId,
      pizzaName: name,
      description: desc,
      price: price,
      imageUrl: image,
    );

    String result = await helper.postPizza(pizza);

    setState(() {
      if (result.contains('The pizza was posted')) {
        operationResult = 'Pizza berhasil ditambahkan!';
      } else {
        operationResult = result.isEmpty ? 'Success!' : result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pizza Detail'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hasil POST
              Text(
                operationResult,
                style: TextStyle(
                  backgroundColor: Colors.green[200],
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              TextField(
                controller: txtId,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Insert ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: txtName,
                decoration: const InputDecoration(
                  hintText: 'Insert Pizza Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  hintText: 'Insert Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: txtPrice,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Insert Price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(
                  hintText: 'Insert Image Url',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 48),

              ElevatedButton(
                onPressed: () async {
                  await postPizza();
                },
                child: const Text('Send Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
