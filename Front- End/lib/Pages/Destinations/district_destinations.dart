// District Destinations Page contaion the Details for each district and its places
import 'package:flutter/material.dart';
import 'places_card.dart';

class AmparaPage extends StatelessWidget {
  const AmparaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ampara'),
      ),
      body: const Center(
        child: Text('Welcome to Ampara!'),
      ),
    );
  }
}

class ColomboPage extends StatelessWidget {
  const ColomboPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colombo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: const [
          PlacesCard(
            imagePath: "assets/images/destinations_images/colombo/Lotus_tower_lg.png",
            title: 'Colombo Lotus Tower',
            location: 'Colombo Lotus Tower, Sri Lanka',
            description:
                'The Lotus Tower, standing at a majestic height of 356 meters, is an iconic symbol of Colombo and the tallest structure in South Asia...',
            likes: 1024, // Example number of likes
          ),
          SizedBox(height: 16),
          PlacesCard(
            imagePath: 'assets/images/destinations_images/colombo/dehiwala_mount_lavinia.jpg',
            title: 'Mount Lavinia Beach',
            location: 'Mount Lavinia Beach, Sri Lanka',
            description:
                'Mount Lavinia Beach is a popular seaside escape just south of Colombo. Known for its golden sands and serene waters...',
            likes: 768, // Example number of likes
          ),
          // Add more cards with likes count for different destinations within Colombo
        ],
      ),
    );
  }
}
