import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/Morning.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/Place_card.dart';



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
    return Card(
      margin: EdgeInsets.all(10),  // Adjust margins as necessary
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mornin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),  // Add spacing before cards
            // Morning Card
            PlaceCard(
              name: name,
              description: description,
              imageUrl: imageUrl,
              weather: weather,
              locationLink: locationLink,
            ),
          ],
        ),
      ),
    );
  }
}
