import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Booking/RoomsView.dart';

class BookingHomePage extends StatelessWidget {
  final String username = "John Doe"; // Replace with actual user data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $username"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification tap
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile tap
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: accommodationPlaces.length,
        itemBuilder: (context, index) {
          return AccommodationCard(
            place: accommodationPlaces[index],
          );
        },
      ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final AccommodationPlace place;

  const AccommodationCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomsView()),
  );
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(place.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                place.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for accommodation places
class AccommodationPlace {
  final String name;
  final String imageUrl;

  AccommodationPlace({required this.name, required this.imageUrl});
}

// Sample data
final List<AccommodationPlace> accommodationPlaces = [
  AccommodationPlace(
    name: "Luxury Hotel",
    imageUrl: "https://example.com/hotel1.jpg",
  ),
  AccommodationPlace(
    name: "Beach Resort",
    imageUrl: "https://example.com/hotel2.jpg",
  ),
  // Add more places as needed
];