import 'package:flutter/material.dart';
import 'Pages/IntroPage/home_page.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackTempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white ,//Color.fromRGBO(255, 255, 255, 0.9)
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // Set HomePage as the initial route
    );
  }
}
