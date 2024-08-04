import 'package:flutter/material.dart';
import 'package:travel_app/Pages/IntroPage/fourthpage.dart';

void main() => runApp(const ThirdPage());


class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/HomeImage02.png', // Adjust the path if needed
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
                      'Crafted',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      ' Adventures!',
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
                  'Enjoy tailor-made travel experiences and curated itineraries. Let TrackTempo help you discover Sri Lanka in your own unique way.',
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
                      context,MaterialPageRoute(builder: (context) => const Fourthpage()));
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

