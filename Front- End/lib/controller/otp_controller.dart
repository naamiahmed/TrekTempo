import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPController {
  // sendOtp sends an OTP to the user's email
  Future<bool> sendOtp(String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://trektempo.onrender.com/api/auth/sendOtp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // verifyOtp verifies the OTP entered by the user
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('https://trektempo.onrender.com/api/auth/verifyOtp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return responseBody['success'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // resetPassword resets the user's password
  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      final response = await http.post(
        Uri.parse('https://trektempo.onrender.com/api/auth/resetPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
