import 'package:flutter/material.dart';
import 'package:travel_app/Pages/ForgotPW/ForgotPassword-OTP.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';

class ForgotPasswordCheckMail extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: TrekTempo_Appbar(),
            extendBodyBehindAppBar: true,
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
                            'assets/images/Forgotpassword-01.png', // Replace with your image path
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Please enter your email address to receive a Verification Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      Icons.email,
                      'Email',
                      emailController,
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: 'Send',
                      onPressed: () {
                        _showEmailSentDialog(context);
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordOTPPage()));
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
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  void _showEmailSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/CheckMail.png', // Replace with your image path
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 0),
              const Text(
                'Check your email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We have sent a Verification Code to your email',
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
    home: ForgotPasswordCheckMail(),
  ));
}
