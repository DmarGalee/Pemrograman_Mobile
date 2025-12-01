import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './model/pizza.dart';

class HttpHelper {
  final String authority = '5l2zy.wiremockapi.cloud';
  final String getPath = 'pizzalist';
  final String postPath = 'pizza'; // FIX: tanpa slash!

  static final HttpHelper _instance = HttpHelper._internal();
  factory HttpHelper() => _instance;
  HttpHelper._internal();

  Future<List<Pizza>> getPizzaList() async {
    final Uri url = Uri.https(authority, getPath);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Pizza.fromJson(item)).toList();
    }
    return [];
  }

  Future<String> postPizza(Pizza pizza) async {
    final Uri url = Uri.https(authority, postPath);
    final String body = json.encode(pizza.toJson());

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("POST → $url");
      print("STATUS → ${response.statusCode}");
      print("BODY → ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return "Error ${response.statusCode}: ${response.body}";
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}
