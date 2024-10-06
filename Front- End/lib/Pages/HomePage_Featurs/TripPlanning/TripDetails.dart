import 'package:flutter/material.dart';

class TripPlanDetails extends StatelessWidget {
  final String tripName = 'Trip Plan Name';
  final String day = 'Day 01';
  final List<Map<String, String>> placesToVisit = [
    {
      'name': 'Place 01',
      'description': 'Description of Place 01',
      'weather': 'Weather Option',
      'locationLink': 'https://locationlink01.com',
    },
    {
      'name': 'Place 02',
      'description': 'Description of Place 02',
      'weather': 'Weather Option',
      'locationLink': 'https://locationlink02.com',
    },
  ];

  final List<Map<String, String>> foodAndAccommodation = [
    {
      'type': 'Restaurant',
      'name': 'Restaurant 01',
      'description': 'Description of Restaurant 01',
      'locationLink': 'https://restaurantlink01.com',
    },
    {
      'type': 'Hotel',
      'name': 'Hotel 01',
      'description': 'Description of Hotel 01',
      'locationLink': 'https://hotellink01.com',
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
              PlaceCard(
                name: place['name']!,
                description: place['description']!,
                weather: place['weather']!,
                locationLink: place['locationLink']!,
              ),
            SizedBox(height: 20),
            Text(
              'Food and Accommodation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var item in foodAndAccommodation)
              PlaceCard(
                name: item['name']!,
                description: item['description']!,
                locationLink: item['locationLink']!,
              ),
          ],
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String name;
  final String description;
  final String weather;
  final String locationLink;

  PlaceCard({
    required this.name,
    required this.description,
    this.weather = '',
    required this.locationLink,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(description),
            if (weather.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('Weather: $weather'),
                ],
              ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                // Handle location link tap
              },
              child: Text(
                'Location Link',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: TripPlanDetails()));
