// Import necessary packages
import 'package:flutter/material.dart';// Import material.dart
 
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DestinationsPage(),
  ));
}

class DestinationsPage extends StatelessWidget {
  const DestinationsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Move the declaration of 'width' inside the build method

    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFFF7F7F9), width: 1.5)), // Add a border to the bottom of the app bar
        title: const Text(
          'Destinations',
           style: 
            TextStyle(
              fontFamily: 'roboto',
              fontSize: 22,
              fontWeight: FontWeight.w600,              
              ),
            ),
          centerTitle: true, // Set title of the page
        backgroundColor: Colors.white, // Set background color to light blue
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, ), onPressed: () {}          
        ),
      ),
      body: 
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/destinationsImages/colombo.jpg",
                      height: 80,
                      width: width-44,
                      fit: BoxFit.cover,
                      
                      
                      )
                  ],
                ),
              )
            ],),
          ),
        ),
    );
  }
}
