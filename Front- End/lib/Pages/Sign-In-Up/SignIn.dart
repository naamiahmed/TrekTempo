import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Sign-In-Up/ForgotPassword-EnterMail.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignUp.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // First column for image
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/SignIn.png'), // Ensure this path is correct
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          // Second and third columns merged for sign-in fields
          Expanded(
            flex: 2,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(1), // Adjust opacity as needed
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                         const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        _buildTextField(Icons.email, 'Email'),
                        const SizedBox(height: 8),
                         const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                          
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        _buildPasswordField(Icons.lock, 'Password'),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Sign In',
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
                              'Don\'t have an account?',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );
                          },
                              child: const Text(
                                ' Sign Up',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 51, 96, 241),
                                  fontWeight: FontWeight.bold,
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
                            ElevatedButton(
                          onPressed: () {
                            // Handle Google sign in
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/Connect-Google.png'), // Ensure this path is correct
                            width: 24,
                            height: 24,
                          ),
                          
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Handle Facebook sign in
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/Connect-FB.png'), // Ensure this path is correct
                            width: 24,
                            height: 24,
                          ),
                        )
                        
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

  Widget _buildTextField(IconData icon, String label) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
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

  Widget _buildPasswordField(IconData icon, String label) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
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
  home: SignInPage(),
));
