import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/userModel.dart';

class NetworkService {
  static const String _baseUrl = "https://jsonplaceholder.typicode.com/";

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse("${_baseUrl}users"));
    print("${_baseUrl}users");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
