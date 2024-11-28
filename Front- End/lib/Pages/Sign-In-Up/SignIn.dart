import 'package:flutter/material.dart';
import 'package:travel_app/Pages/ForgotPW/ForgotPassword-EnterMail.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/TopImage.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignUp.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/InputTextBox.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'package:travel_app/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService apiService = ApiService(); 

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomePage()),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const TrekTempo_Appbar(showBackButton: false),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopImage(height: height, width: width, imagePath: 'assets/images/SignIn.png'),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                      obscureText: _obscurePassword,
                      toggleObscureText: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Button(
                        text: 'Sign In',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Call the sign-in method
                            String? errorMessage = await apiService.signIn(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (errorMessage == null) {
                              // Save login status
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);

                              // Navigate to the home page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MainHomePage()),
                              );
                            } else {
                              // Show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
                              );
                            }
                          } else {
                            // print("Validation failed");
                          }
                        },
                        textColor: Colors.white,
                        buttonColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Sign Up',
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