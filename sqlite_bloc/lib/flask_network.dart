import 'drink.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = "http://127.0.0.1:5000/drink";
  Drink drink;
  //* Get all drink list
  Future<List<Drink>> getDrinks() async {
    await Future.delayed(Duration(seconds: 3));
    final response = await http
        .get('$baseUrl', headers: {"Content-Type": "Application/json"});

    final decoded = json.decode(response.body) as List;

    return decoded
        .cast<Map<String, dynamic>>()
        .map((json) => Drink.fromJson(json))
        .toList();
  }

  //* Get a single drink from the api
  Future<Drink> getDrinkById(int id) async {
    final response = await http
        .get('$baseUrl/$id', headers: {"Content-Type": "Application/json"});
    var decoded = jsonDecode(response.body);
    var drink = Drink.fromJson(decoded);

    return drink;
  }
}
