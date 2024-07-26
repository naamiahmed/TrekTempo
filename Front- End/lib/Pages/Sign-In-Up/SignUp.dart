import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/Pages/Sign-In-Up/signIn.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // First column for the image
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/SignUp.png'), // Ensure this path is correct
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Second and third columns merged for the sign-up fields
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5), // Adjust opacity as needed
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign up now',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Please fill the details and create account',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(Icons.person, 'Username',Color.fromARGB(255, 60, 60, 60)),
                        const SizedBox(height: 8),
                        _buildTextField(Icons.email, 'Email',Color.fromARGB(255, 60, 60, 60)),
                        const SizedBox(height: 8),
                        _buildPasswordField(Icons.lock, 'Password',Color.fromARGB(255, 60, 60, 60)),
                        const SizedBox(height: 8),
                        _buildPasswordField(Icons.lock, 'Confirm Password',Color.fromARGB(255, 60, 60, 60)),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign in page
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 51, 96, 241),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                             'Or connect',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                                     ),
                            ),
                          ],
                              ),
                        
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Handle Google sign in
                              },
                              icon: const Icon(
                                  Icons.account_circle, color: Colors.white),
                              iconSize: 40,
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              onPressed: () {
                                // Handle Facebook sign in
                              },
                              icon:
                                  const Icon(Icons.facebook, color: Colors.white),
                              iconSize: 40,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hintText, Color color) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField(IconData icon, String hintText, Color color) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

void main() => runApp(MaterialApp(
  home: SignUpPage(),
));
