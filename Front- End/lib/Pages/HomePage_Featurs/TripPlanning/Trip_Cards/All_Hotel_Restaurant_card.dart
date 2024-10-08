import 'package:flutter/material.dart';
import 'hotel_restaurant_card.dart';

class AllHotelRestaurantCard extends StatelessWidget {
  final String name;
  final String description;
  final String locationLink;
  final String imageUrl;

  AllHotelRestaurantCard({
    required this.name,
    required this.description,
    required this.locationLink,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelRestaurantCard(
              name: name,
              description: description,
              locationLink: locationLink,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
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
            ],
          ),
        ),
      ),
    );
  }
}