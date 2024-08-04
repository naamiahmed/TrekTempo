import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignUp.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignIn.dart';

void main() => runApp(const Fourthpage());


class Fourthpage extends StatelessWidget {
  const Fourthpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/HomeImage03.png', // Adjust the path if needed
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                const Positioned(
                  top: 50,
                  right: 20,
                  child: Text(
                    'Skip >',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adventure',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ' Awaits!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 112, 41, 1),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/HomeLine.png',
                  height: 20,
                  
                  alignment: const Alignment(5,0),),
                const SizedBox(height: 16),
                const Text(
                  'Unleash your wanderlust and explore Sri Lankas natural beauty and cultural richness with TrackTempo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
