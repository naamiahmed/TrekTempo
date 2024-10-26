import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'package:travel_app/Pages/ForgotPW/Components/Button.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordPage({super.key});

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
                            'assets/images/ForgotPassword-03.png', // Replace with your image path
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
                      Icons.lock,
                      'Enter New Password',
                      emailController,
                    ),
                     const SizedBox(height: 16),
                    _buildTextField(
                      Icons.lock,
                      'Confirm New Password',
                      emailController,
                    ),
                    const SizedBox(height: 26),
                    Button(
                      text: 'Submit',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHomePage(),
                          ),
                        );
                         
                        // Handle send email
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
}

void main() {
  runApp(MaterialApp(
    home: ResetPasswordPage(),
  ));
}
