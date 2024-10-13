import 'package:flutter/material.dart';
import 'package:travel_app/Pages/IntroPage/Components/ImagesDesign.dart';
import 'fourthpage.dart';

void main() => runApp(const ThirdPage());

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageDesign(
      imagePath: 'assets/images/HomeImage02.png',
      titlePart1: 'Crafted',
      titlePart2: ' Adventures!',
      description: 'Enjoy tailor-made travel experiences and curated itineraries. Let TrackTempo help you discover Sri Lanka in your own unique way.',
      nextPage: Fourthpage(),
    );
  }
}