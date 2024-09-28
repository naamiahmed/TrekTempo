import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Sign-In-Up/signIn.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/TopImage.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/InputTextBox.dart';
import 'package:travel_app/auth_service.dart'; // Make sure this points to your ApiService

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final ApiService apiService = ApiService(); // Create an instance of ApiService

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6 || value.length > 12) {
      return 'Password must be 6 to 12 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password cannot be empty';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      // Call the API service to sign up
      bool success = await apiService.signUp(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      
      if (success) {
        // Navigate to Sign In Page or show success message
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up failed! Please try again.')),
        );
      }
    } else {
      print("Validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: TrekTempo_Appbar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopImage(height: height, width: width, imagePath: 'assets/images/SignUp.png'),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign up now',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please fill the details and create account',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 81, 80, 80),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InputTextBox(
                      icon: Icons.person,
                      label: 'Username',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.email,
                      label: 'Email',
                      controller: _emailController,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.lock,
                      label: 'Password',
                      isPassword: true,
                      controller: _passwordController,
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.lock,
                      label: 'Confirm Password',
                      isPassword: true,
                      controller: _confirmPasswordController,
                      validator: (value) => _validateConfirmPassword(value, _passwordController.text),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Button(
                        text: 'Sign Up',
                        onPressed: _signUp,
                        textColor: Colors.white,
                        buttonColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignInPage()),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}