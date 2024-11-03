import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Pages/ForgotPW/ResetPassword.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/controller/otp_controller.dart';

class ForgotPasswordOTPPage extends StatelessWidget {
  final String email;
  final TextEditingController otpController = TextEditingController();
  final OTPController otpControllerInstance = OTPController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ForgotPasswordOTPPage({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TrekTempo',
          style: GoogleFonts.lobster(
            fontSize: 30,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                          'assets/images/ForgotPassword-01.png',
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
                  SizedBox(
                    height: 65,
                    child: _buildTextField(
                      'OTP',
                      otpController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    text: 'Verify',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String otp = otpController.text;
                        bool isVerified =
                            await otpControllerInstance.verifyOtp(email, otp);
                        if (isVerified) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResetPasswordPage(email: email)),
                          );
                        } else {
                          _showInvalidOtpDialog(context);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.black),
        labelText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        constraints: const BoxConstraints.expand(height: 50),
        filled: true,
        fillColor: Colors.grey[300],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        errorMaxLines: 1,
        errorStyle:
            const TextStyle(height: 0.8),
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the OTP';
        }
        return null;
      },
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
