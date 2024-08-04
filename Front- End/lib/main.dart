import 'package:flutter/material.dart';
import 'Pages/IntroPage/home_page.dart';
import 'Pages/IntroPage/fourthpage.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrekTempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // Set HomePage as the initial route
    );
  }
}
