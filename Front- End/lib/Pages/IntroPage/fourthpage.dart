import 'package:flutter/material.dart';
import 'package:travel_app/Pages/IntroPage/Components/ImagesDesign.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignIn.dart';

void main() => runApp(const Fourthpage());

class Fourthpage extends StatelessWidget {
  const Fourthpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageDesign(
      imagePath: 'assets/images/HomeImage03.png',
      titlePart1: 'Adventure',
      titlePart2: ' Awaits!',
      description: 'Unleash your wanderlust and explore Sri Lanka\'s natural beauty and cultural richness with TrackTempo.',
      nextPage: SignInPage(),
    );
  }
}