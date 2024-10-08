import 'package:flutter/material.dart';
import 'place_card.dart';

class NightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;

  NightCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
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
            Image.network(imageUrl),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 5),
            Text(description),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceCard(
                      name: title,
                      description: description,
                      weather: '',
                      locationLink: '',
                      imageUrl: imageUrl,
                    ),
                  ),
                );
              },
              child: Text(
                'View Details',
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