import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignIn.dart';
import 'package:travel_app/controller/otp_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final OTPController otpController =
      OTPController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ResetPasswordPage({required this.email, super.key});

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
                children: [
                  const Text(
                    'Reset password',
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
                          'assets/images/ForgotPassword-03.png',
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please enter your new password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    Icons.lock,
                    'Enter New Password',
                    newPasswordController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    Icons.lock,
                    'Confirm New Password',
                    confirmPasswordController,
                  ),
                  const SizedBox(height: 26),
                  Button(
                    text: 'Submit',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (newPasswordController.text ==
                            confirmPasswordController.text) {
                          bool success = await otpController.resetPassword(
                              email, newPasswordController.text);
                          if (success) {
                            _showSuccessMessage(
                                context, 'Password changed successfully');
                            await Future.delayed(const Duration(seconds: 2));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          } else {
                            _showErrorDialog(
                                context, 'Failed to reset password');
                          }
                        } else {
                          _showErrorDialog(context, 'Passwords do not match');
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

  Widget _buildTextField(
      IconData icon, String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle:
            const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(
            color: Colors.black),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        return null;
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Error',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
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

  void _showSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

void main() {
  runApp(MaterialApp(
    home: ResetPasswordPage(email: 'example@example.com'),
  ));
}
