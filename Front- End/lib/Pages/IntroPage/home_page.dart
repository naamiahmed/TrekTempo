import 'package:flutter/material.dart';
import 'secondPage.dart'; // Ensure this path is correct

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Start a delay to navigate to the next page
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondPage()),
      );
    });

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 33, 150, 243), // Set background color to light blue
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              Image(
                image: AssetImage('assets/images/Logo.png'), // Ensure this path is correct
                height: 200, // Set height as needed
                width: 200, // Set width as needed
              ),
              SizedBox(height: 20), // Add some space between the image and text
              Text(
                'TrekTempo',
                style: TextStyle(
                  fontFamily: 'ShortBaby',
                  color: Colors.white, // Change font color to white
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 10), // Add space between title and subtitle
              Text(
                'Find your dream Destination with us',
                style: TextStyle(
                  color: Colors.white, // Change font color to white
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
