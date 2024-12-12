import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String loginUrl = 'https://reqres.in/api/login';

  static Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Invalid email or password');
    }
  }
}
