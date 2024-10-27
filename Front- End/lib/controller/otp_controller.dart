import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPController {
  static Future<http.Response> sendOTP(String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/auth/sendOtp'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to send OTP: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }
}