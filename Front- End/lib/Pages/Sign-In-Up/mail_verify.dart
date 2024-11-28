import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/Pages/Sign-In-Up/signIn.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';
import 'package:travel_app/auth_service.dart';

class MailVerifyPage extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const MailVerifyPage({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  _MailVerifyPageState createState() => _MailVerifyPageState();
}

class _MailVerifyPageState extends State<MailVerifyPage> {
  final _otpController = TextEditingController();
  final ApiService apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;

    String otp = _otpController.text.trim();
    setState(() => _isLoading = true);
    
    try {
      bool otpVerified = await apiService.verifySignUpOTP(widget.email, otp);
      if (otpVerified) {
        bool signupSuccess = await apiService.signUp(
          widget.name,
          widget.email,
          widget.password,
        );

        if (signupSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInPage()),
            (route) => false,
          );
        } else {
          _showErrorDialog('Registration failed. Please try again.');
        }
      } else {
        _showErrorDialog('Invalid OTP. Please try again.');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
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
        errorStyle: const TextStyle(height: 0.8),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
                    'Email Verification',
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
                  Text(
                    'Enter the OTP sent to ${widget.email}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 65,
                    child: _buildTextField(
                      'OTP',
                      _otpController,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    text: _isLoading ? 'Verifying...' : 'Verify',
                    onPressed: _isLoading ? () {} : _verifyOTP,
                    textColor: Colors.white,
                    buttonColor: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
