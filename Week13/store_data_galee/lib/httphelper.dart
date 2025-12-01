import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pizza.dart';
import 'dart:io';

class HttpHelper {
  final String authority = '5l2zy.wiremockapi.cloud';
  final String getPath = 'pizzalist';
  final String postPath = 'pizza';
  final String putPath = 'pizza';
  final String deletePath = 'pizza';

  static final HttpHelper _instance = HttpHelper._internal();
  factory HttpHelper() => _instance;
  HttpHelper._internal();

  // GET — sudah ada & benar
  Future<List<Pizza>> getPizzaList() async {
    final Uri url = Uri.https(authority, getPath);
    print("GET URL  → $url");

    try {
      final response = await http.get(url);
      print("STATUS   → ${response.statusCode}");
      print("RESP BODY→ ${response.body}");

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Pizza.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("GET ERROR → $e");
      return [];
    }
  }

  // === POST PIZZA (DIPERBAIKI) ===
  Future<String> postPizza(Pizza pizza) async {
    // Tambahkan ?id= di URL biar cocok dengan stub WireMock kamu
    final Uri url = Uri.https(authority, postPath, {'id': pizza.id.toString()});
    final body = jsonEncode(pizza.toJson());

    print("POST URL  → $url"); // https://5l2zy.wiremockapi.cloud/pizza?id=99
    print("POST BODY → $body");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      print("STATUS     → ${response.statusCode}");
      print("RESP BODY  → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Pizza berhasil ditambahkan!";
      } else {
        return "Error ${response.statusCode}";
      }
    } catch (e) {
      return "Exception: $e";
    }
  }

  // TAMBAHAN POIN 3: PUT PIZZA
  Future<String> putPizza(Pizza pizza) async {
    final Uri url = Uri.https(authority, putPath);
    final body = jsonEncode(pizza.toJson());

    print("PUT URL   → $url");
    print("PUT BODY  → $body");

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json', // WAJIB ADA!
        },
        body: body,
      );

      print("PUT STATUS → ${response.statusCode}");
      print("PUT RESP   → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return "Pizza berhasil diperbarui!";
      } else {
        return "PUT Error ${response.statusCode}: ${response.body}";
      }
    } catch (e) {
      return "PUT Exception: $e";
    }
  }

  Future<String> deletePizza(int id) async {
    const deletePath = '/pizza';
    Uri url = Uri.https(authority, deletePath);
    http.Response r = await http.delete(url);
    return r.body;
  }
}
