import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/AccommodationDetails.dart';

class AccommodationCard extends StatelessWidget {
  final String district;
  final List<String> imagePaths;
  final String title;
  final String location;
  final String description;
  final int likes;
  final String locationLink;

  const AccommodationCard({
    super.key,
    required this.district,
    required this.imagePaths,
    required this.title,
    required this.location,
    required this.description,
    required this.likes,
    required this.locationLink,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccommodationDetails(
              district: district,
              imagePaths: imagePaths,
              title: title,
              location: location,
              description: description,
              likes: likes,
              locationLink: locationLink,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imagePaths[0],
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Title, Location, and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Like Icon and Count
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$likes', // Display number of likes
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}