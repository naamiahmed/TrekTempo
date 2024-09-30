import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:5000/api/auth'; // Update with your backend URL

  // Sign Up Method
  Future<bool> signUp(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Sign up successful');
      return true;
    } else {
      print('Sign up failed: ${response.body}');
      return false;
    }
  }

  // Sign In Method
  Future<bool> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Sign in successful');
      return true;
    } else {
      print('Sign in failed: ${response.body}');
      return false;
    }
  }
}