import 'drink.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = "http://127.0.0.1:5000/drink";
  Drink drink;
  //* Get all drink list
  Future<List<Drink>> getDrinks() async {
    await Future.delayed(Duration(seconds: 3));
    final response = await http.get('$baseUrl');

    final decoded = json.decode(response.body) as List;

    return decoded
        .cast<Map<String, dynamic>>()
        .map((json) => Drink.fromJson(json))
        .toList();
  }

  //* Get a single drink from the api
  Future<Drink> getDrink({int id}) async {
    final response = await http.get('$baseUrl/$id');
    final decoded = json.decode(response.body);
    print(decoded);
    Drink d = decoded.map((json) => Drink.fromJson(json));
    return d;
  }
}
