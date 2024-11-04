import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5000/api/auth'; // Update with your backend URL

  // Sign Up Method
  Future<bool> signUp(String name, String email, String password) async {
    try {
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

      // Parse response body
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        print('Sign up successful');
        return true;
      } else {
        print('Sign up failed: ${data['message'] ?? 'Unknown error'}');
        return false;
      }
    } catch (e) {
      print('Exception during sign up: $e');
      return false;
    }
  }

  // Sign In Method
  Future<String?> signIn(String email, String password) async {
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
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // Extract user data and token
      final user = jsonData['user'];
      final token = jsonData['token'];

      if (user != null && token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Save data to SharedPreferences
        await prefs.setString('userName', user['name']);
        await prefs.setString('userEmail', user['email']);
        await prefs.setString('userId', user['_id']);
        await prefs.setString('token', token);

        print('Sign in successful, data saved to SharedPreferences');
        return null; // No error
      } else {
        return 'Failed to parse user data or token';
      }
    } else {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['msg'] ?? 'Sign in failed';
    }
  }

  // Send OTP for signup verification
  Future<bool> sendSignUpOTP(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/send-signup-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        print('OTP sent successfully');
        return true;
      } else {
        print('Failed to send OTP: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  // Verify OTP for signup
  Future<bool> verifySignUpOTP(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify-signup-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        print('OTP verified successfully');
        return true;
      } else {
        print('OTP verification failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return false;
    }
  }
}