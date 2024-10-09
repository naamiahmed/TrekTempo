// places of distrcits

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/TripPlace.dart';
import 'package:travel_app/Pages/Destinations/places_card.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Start_End.dart';

class TripPlaceCard extends StatefulWidget {
  final String district; // Add a field to hold the district name

  const TripPlaceCard(
      {super.key, required this.district}); // Modify the constructor

  @override
  State<TripPlaceCard> createState() => _TripPlaceCardState();
}

class _TripPlaceCardState extends State<TripPlaceCard> {
  List<TripPlace> fetchedPlaces = [];
  late Future<String> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchPlacesData();
  }

  Future<String> fetchPlacesData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/getTripPlaces/${widget.district}'),
        headers: {},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> placesJson = jsonData['TripPlaces'];
        for (var placeJson in placesJson) {
          TripPlace place = TripPlace.fromJson(placeJson);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.district),
        centerTitle: true,
      ),
      body: fetchedPlaces.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: fetchedPlaces.length,
              itemBuilder: (context, index) {
                final place = fetchedPlaces[index];
                return Column(
                  children: [
                    PlacesCard(
                      imagePaths: place.images,
                      title: place.name,
                      location: place.location,
                      description: place.description,
                      likes: place.weather, district: '',
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
    );
  }
}
