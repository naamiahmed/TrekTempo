import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:5000/api/auth';

  Future<Map<String, dynamic>> signup(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'newPassword': newPassword}),
    );

    return json.decode(response.body);
  }
}
