import 'package:flutter/material.dart';
import 'package:travel_app/Pages/IntroPage/Components/ImagesDesign.dart';
import 'third_page.dart';

void main() => runApp(const SecondPage());

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageDesign(
      imagePath: 'assets/images/home_image01.png',
      titlePart1: 'Explore',
      titlePart2: ' Sri Lanka!',
      description: 'Welcome to TrackTempo, your ultimate guide to exploring Sri Lanka\'s hidden gems and must-see destinations',
      nextPage: ThirdPage(),
    );
  }
}