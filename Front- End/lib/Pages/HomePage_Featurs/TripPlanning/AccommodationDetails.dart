import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/Accommodation.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/AccommodationCard.dart';
import 'package:http/http.dart' as http;

class AccommodationDetails extends StatefulWidget {
  final String endPoint;
  final String budget;
  final String tripPersonType;
  final String tripType;
  const AccommodationDetails(
      {super.key,
      required this.endPoint,
      required this.budget,
      required this.tripPersonType,
      required this.tripType});
  @override
  State<AccommodationDetails> createState() => _AccommodationDetailsState();
}

class _AccommodationDetailsState extends State<AccommodationDetails> {
  List<Accommodation> fetchedAccommodations = [];

  late Future<String> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchaccommodationsData();
  }

  Future<String> fetchaccommodationsData() async {
    try {
      final Map<String, dynamic> data = {
        "endPoint": widget.endPoint,
        "budget": widget.budget,
        "tripPersonType": widget.tripPersonType,
        "tripType": widget.tripType
      };
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/getAccommodation'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        List<dynamic> accommodationJson = jsonData['Accommodation'];
        for (var accommodationJson in accommodationJson) {
          Accommodation accommodation = Accommodation.fromJson(accommodationJson);
          setState(() {
            fetchedAccommodations.add(accommodation);
          });
        }
      } else {
        print('Failed to fetch data ${response.body}');
      }
    } catch (er) {
      print(er);
    }
    await Future.delayed(const Duration(seconds: 1));
    return "done";
  }

  final String tripName = 'Trip Accommodation Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tripName),
      ),
      body: fetchedAccommodations.isEmpty
          ? const Center(
              child: Text(
                "No Results Found",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: fetchedAccommodations.length,
              itemBuilder: (context, index) {
                final place = fetchedAccommodations[index];
                return Column(
                  children: [
                    AccommodationCard(
                      district: place.district,
                      imagePaths: place.images,
                      title: place.name,
                      location: place.location,
                      description: place.description,
                      locationLink: place.locationLink,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
    );
  }
}
