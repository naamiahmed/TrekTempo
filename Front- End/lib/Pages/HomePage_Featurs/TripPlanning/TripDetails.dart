import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/Place.dart';
import 'package:travel_app/Models/TripPlanInputs.dart';
import 'package:travel_app/Pages/Destinations/district_places_card.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/TripPlanCard.dart';
import 'Trip_Cards/All_place_card.dart';
import 'Trip_Cards/All_Hotel_Restaurant_card.dart';
import 'package:http/http.dart' as http;

class TripPlanDetails extends StatefulWidget {
  final String endPoint;
  final String budget;
  final String tripPersonType;
  final String tripType;
  const TripPlanDetails(
      {Key? key,
      required this.endPoint,
      required this.budget,
      required this.tripPersonType,
      required this.tripType})
      : super(key: key);
  @override
  State<TripPlanDetails> createState() => _TripPlanDetailsState();
}

class _TripPlanDetailsState extends State<TripPlanDetails> {
  List<Place> fetchedPlaces = [];

  late Future<String> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchPlacesData();
  }

  Future<String> fetchPlacesData() async {
    try {
      final Map<String, dynamic> data = {
        "endPoint": widget.endPoint,
        "budget": widget.budget,
        "tripPersonType": widget.tripPersonType,
        "tripType": widget.tripType
      };
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/getTripPlaces'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        List<dynamic> placesJson = jsonData['TripPlaces'];
        for (var placeJson in placesJson) {
          Place place = Place.fromJson(placeJson);
          setState(() {
            fetchedPlaces.add(place);
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

  final String tripName = 'Trip Plan Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tripName),
      ),
      body: fetchedPlaces.isEmpty
          ? const Center(
              child: Text(
                "No Results Found",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: fetchedPlaces.length,
              itemBuilder: (context, index) {
                final place = fetchedPlaces[index];
                return Column(
                  children: [
                    TripPlanCard(
                      district: place.district,
                      imagePaths: place.images,
                      title: place.name,
                      location: place.location,
                      description: place.description,
                      likes: place.likes,
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
