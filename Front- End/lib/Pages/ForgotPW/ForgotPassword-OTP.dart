import 'package:flutter/material.dart';
import 'package:travel_app/Pages/ForgotPW/ResetPassword.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';

class ForgotPasswordOTPPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrekTempo_Appbar(),
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
                            'assets/images/ForgotPassword-02.png', // Replace with your image path
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Please enter your email www.TrekTempo@gmail.com to see the verification code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildTextField(
                            Icons.email,
                            'Email',
                            emailController,
                          ),
                        ),
                        SizedBox(width: 15), // Add space between text fields
                        Expanded(
                          child: _buildTextField(
                            Icons.email,
                            'Email',
                            emailController,
                          ),
                        ),
                        SizedBox(width: 15), // Add space between text fields
                        Expanded(
                          child: _buildTextField(
                            Icons.email,
                            'Email',
                            emailController,
                          ),
                        ),
                        SizedBox(width: 15), // Add space between text fields
                        Expanded(
                          child: _buildTextField(
                            Icons.email,
                            'Email',
                            emailController,
                          ),
                        ),
                      ],
                    ),
            
                    const SizedBox(height: 16),
                   Button(
                      text: 'Verify',
                      onPressed: () {
                         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()));
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
        constraints: BoxConstraints.expand(width: 50, height: 50),
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

  void _showEmailSentDialog(BuildContext context) {
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
              Image.asset(
                'assets/images/email_sent.png', // Replace with your image path
                width: 150,
                height: 100,
              ),
              const SizedBox(height: 20),
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
    home: ForgotPasswordOTPPage(),
  ));
}
