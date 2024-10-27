import 'package:flutter/material.dart';
import 'package:travel_app/Pages/ForgotPW/ResetPassword.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';
import 'package:travel_app/controller/otp_controller.dart'; // Import the OTP controller

class ForgotPasswordOTPPage extends StatelessWidget {
  final String email;
  final TextEditingController otpController = TextEditingController();
  final OTPController otpControllerInstance = OTPController(); // Create an instance of OTPController

  ForgotPasswordOTPPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TrekTempo_Appbar(),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0), // Add some space at the top
                    const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/ForgotPassword-02.png', 
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Enter your OTP Code here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      Icons.lock,
                      'OTP',
                      otpController,
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: 'Verify',
                      onPressed: () async {
                        String otp = otpController.text;
                        bool isVerified = await otpControllerInstance.verifyOtp(email, otp);
                        if (isVerified) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordPage(email: email)),
                          );
                        } else {
                          _showInvalidOtpDialog(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        constraints: const BoxConstraints.expand(height: 50),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  void _showInvalidOtpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Invalid OTP',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'The OTP you entered is invalid or has already been used.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ForgotPasswordOTPPage(email: 'example@example.com'),
  ));
}
