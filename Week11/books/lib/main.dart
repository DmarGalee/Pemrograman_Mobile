import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart'; // Package async/async diperlukan untuk FutureGroup

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // Menggunakan 'Widget' sebagai tipe kembalian
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DamarGalee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = ''; // Variabel untuk menyimpan hasil operasi asinkron

  // Variabel Completer (Praktikum 3)
  late Completer completer;

  // --- FUNGSI ASINKRON DASAR (Praktikum 2, Langkah 1) ---
  Future<int> returnOneAsync() async {
    // Menunggu 3 detik
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    // Menunggu 3 detik
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    // Menunggu 3 detik
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  // --- METHOD returnError() - Mensimulasikan Error (Praktikum 5, Langkah 1) ---
  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  // --- METHOD handleError() - Menangani Error dengan async/await (Praktikum 5, Langkah 4) ---
  Future handleError() async {
    try {
      // Menjalankan Future yang diketahui akan melempar error
      await returnError();
    } catch (error) {
      // Menangkap error dan memperbarui UI
      setState(() {
        result = error.toString();
      });
    } finally {
      // Blok yang selalu dijalankan, baik sukses maupun error
      print('Complete');
    }
  }
  // ---------------------------------------------------------------------------

  // --- METHOD count() - Eksekusi Berurutan (Sequential) ---
  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();

    setState(() {
      result = total.toString();
    });
  }

  // --- METHOD returnFG() - Eksekusi Serentak (Parallel) menggunakan Future.wait (Praktikum 4, Langkah 4) ---
  void returnFG() {
    // 1. Definisikan list of futures
    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);

    // 2. Gunakan .then() untuk mendengarkan hasil dari Future.wait
    futures.then(((List<int> value) {
      int total = 0;
      // Menjumlahkan semua hasil yang dikembalikan secara serentak
      for (var element in value) {
        total += element;
      }

      setState(() {
        result = total.toString();
      });
    }));
  }
  // --------------------------------------------------------

  // Method getNumber() untuk inisiasi Completer (Praktikum 3, Langkah 2)
  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  // Method calculate() dengan try-catch untuk Completer (Praktikum 3, Langkah 5)
  Future calculate() async {
    try {
      // Simulasi pekerjaan berat selama 5 detik
      await Future.delayed(const Duration(seconds: 5));
      // Menyelesaikan Completer dengan nilai 42 jika berhasil
      completer.complete(42);

      // Aktifkan baris di bawah ini untuk menguji catchError() di onPressed:
      // throw Exception('Error test');
    } catch (_) {
      // Jika terjadi Exception, selesaikan Completer dengan error
      completer.completeError({});
    }
  }

  // Method untuk mengambil data dari Google Books API (kode awal)
  Future<http.Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/8ZI48GCDWu0C';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                // PANGGILAN returnError() dengan penanganan Error lengkap (Praktikum 5, Langkah 2)
                /* Kode sebelumnya:
                returnError()
                  .then((value) {
                    setState(() {
                      result = 'Success';
                    });
                  })
                  .catchError((onError) {
                    // Menangkap error yang dilempar oleh returnError()
                    setState(() {
                      result = onError.toString();
                    });
                  })
                  .whenComplete(() => print('Complete')); // Selalu dijalankan
                */

                // PANGGILAN handleError()
                handleError();

                /* Semua kode sebelumnya di-comment:
                returnFG();
                getNumber().then((value) {
                  setState(() {
                    result = value.toString();
                  });
                }).catchError((e) { 
                  setState(() {
                    result = 'An error occurred';
                  });
                });
                count();
                setState(() {});
                getData().then((value) {
                  String rawBody = value.body.toString();
                  String slicedContent = rawBody.substring(
                    0,
                    rawBody.length > 450 ? 450 : rawBody.length,
                  );
                  // ... logika parsing/setState
                }).catchError((_) {
                  // ... logika error
                });
                */
              },
            ),
            const Spacer(),
            // Widget Text untuk menampilkan hasil/loading/error
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                result.isEmpty ? 'Tekan GO!' : result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const Spacer(),
            // CircularProgressIndicator
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
