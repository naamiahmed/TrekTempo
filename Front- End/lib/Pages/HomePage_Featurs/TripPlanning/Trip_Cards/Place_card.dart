import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String description;
  final String weather;
  final String locationLink;
  final String imageUrl;

  PlaceCard({
    required this.name,
    required this.description,
    this.weather = '',
    required this.locationLink,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(description),
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
            if (weather.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('Weather: $weather'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}