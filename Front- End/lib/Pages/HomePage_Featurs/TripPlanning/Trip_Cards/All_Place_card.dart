import 'package:flutter/material.dart';
import 'place_card.dart';
import 'Morining.dart';
import 'Evening.dart';
import 'Night.dart';

class AllPlaceCard extends StatelessWidget {
  final String name;
  final String description;
  final String weather;
  final String locationLink;
  final String imageUrl;

  AllPlaceCard({
    required this.name,
    required this.description,
    this.weather = '',
    required this.locationLink,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MorningCard(
          title: name,
          subtitle: 'Morning',
          description: description,
          imageUrl: imageUrl,
        ),
        EveningCard(
          title: name,
          subtitle: 'Evening',
          description: description,
          imageUrl: imageUrl,
        ),
        NightCard(
          title: name,
          subtitle: 'Night',
          description: description,
          imageUrl: imageUrl,
        ),
      ],
    );
  }
}