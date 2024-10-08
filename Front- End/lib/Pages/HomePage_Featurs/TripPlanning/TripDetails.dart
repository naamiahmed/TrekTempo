import 'package:flutter/material.dart';
import 'Trip_Cards/All_place_card.dart';
import 'Trip_Cards/All_Hotel_Restaurant_card.dart';

class TripPlanDetails extends StatelessWidget {
  final String tripName = 'Trip Plan Name';
  final String day = 'Day 01';
  final List<Map<String, String>> placesToVisit = [
    {
      'name': 'Place 01',
      'description': 'Description of Place 01',
      'weather': 'Weather Option',
      'locationLink': 'https://locationlink01.com',
      'imageUrl': 'https://example.com/image01.jpg',
    },
    {
      'name': 'Place 02',
      'description': 'Description of Place 02',
      'weather': 'Weather Option',
      'locationLink': 'https://locationlink02.com',
      'imageUrl': 'https://example.com/image02.jpg',
    },
  ];

  final List<Map<String, String>> foodAndAccommodation = [
    {
      'type': 'Restaurant',
      'name': 'Restaurant 01',
      'description': 'Description of Restaurant 01',
      'locationLink': 'https://restaurantlink01.com',
      'imageUrl': 'https://example.com/restaurant01.jpg',
    },
    {
      'type': 'Hotel',
      'name': 'Hotel 01',
      'description': 'Description of Hotel 01',
      'locationLink': 'https://hotellink01.com',
      'imageUrl': 'https://example.com/hotel01.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tripName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Places to Visit',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var place in placesToVisit)
              AllPlaceCard(
                name: place['name']!,
                description: place['description']!,
                weather: place['weather']!,
                locationLink: place['locationLink']!,
                imageUrl: place['imageUrl']!,
              ),
            SizedBox(height: 20),
            Text(
              'Food and Accommodation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var item in foodAndAccommodation)
              AllHotelRestaurantCard(
                name: item['name']!,
                description: item['description']!,
                locationLink: item['locationLink']!,
                imageUrl: item['imageUrl']!,
              ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: TripPlanDetails()));