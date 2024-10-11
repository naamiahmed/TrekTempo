import 'package:flutter/material.dart';
import 'second_page.dart'; // Ensure this path is correct

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
        color: const Color.fromARGB(255, 33, 150, 243), 
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Image(
                image: AssetImage('assets/images/Logo.png'),
                height: 100, 
                width: 100, 
              ),
              SizedBox(height: 20), 
              Text(
                'TrackTempo',
                style: TextStyle(
                  fontFamily: 'ShortBaby',
                  color: Colors.white, 
                  fontSize: 50,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Find your dream destination with us', 
                textAlign: TextAlign.center, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16, 
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
