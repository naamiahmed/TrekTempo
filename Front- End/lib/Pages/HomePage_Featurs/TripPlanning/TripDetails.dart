import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/Place.dart';
import 'package:travel_app/Models/Accommodation.dart';
import 'package:travel_app/Models/TripPlace.dart';
import 'package:travel_app/Models/TripPlanInputs.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/TripPlanCard.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/AccommodationCard.dart';
import 'package:travel_app/Pages/HomePage_Featurs/AddAccommodation/new_accomadation_form.dart';
import 'package:http/http.dart' as http;

class TripPlanDetails extends StatefulWidget {
  final String endPoint;
  final String budget;
  final String tripPersonType;
  final String tripType;
  const TripPlanDetails(
      {super.key,
      required this.endPoint,
      required this.budget,
      required this.tripPersonType,
      required this.tripType});
  @override
  State<TripPlanDetails> createState() => _TripPlanDetailsState();
}

class _TripPlanDetailsState extends State<TripPlanDetails> {
  List<TripPlace> fetchedTripPlaces = [];
  List<Accommodation> fetchedAccommodations = [];

  late Future<String> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchPlacesData();
    futureData = fetchAccommodationsData();
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
        List<dynamic> tripplacesJson = jsonData['TripPlaces'];
        for (var placeJson in tripplacesJson) {
          TripPlace tripplace = TripPlace.fromJson(placeJson);
          setState(() {
            fetchedTripPlaces.add(tripplace);
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

  Future<String> fetchAccommodationsData() async {
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
        List<dynamic> accommodationJson = jsonData['Accommodations'];
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


  final String tripName = 'Trip Plan Name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tripName),
      ),
      body: fetchedTripPlaces.isEmpty
          ? const Center(
          child: Text(
            "No Results Found",
            style: TextStyle(fontSize: 18),
          ),
        )
          : ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const Text(
                    'Trip Places',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fetchedTripPlaces.length,
          itemBuilder: (context, index) {
            final tripplace = fetchedTripPlaces[index];
            return Column(
              children: [
            TripPlanCard(
              district: tripplace.district,
              imagePaths: tripplace.images,
              title: tripplace.name,
              location: tripplace.location,
              description: tripplace.description,
              locationLink: tripplace.locationLink,
              
            ),
            const SizedBox(height: 16),
              ],
            );
          },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text(
                'Accommodations',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) =>const NewAccommodationForm(userId: '',)
                  ),
                );
                },
              ),
              ],
            ),
            ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fetchedAccommodations.length,
          itemBuilder: (context, index) {
            final accommodation = fetchedAccommodations[index];
            return Column(
              children: [
            AccommodationCard(
              district: accommodation.district,
              imagePaths: accommodation.images,
              title: accommodation.name,
              location: accommodation.location,
              description: accommodation.description,
              locationLink: accommodation.locationLink,
            ),
            const SizedBox(height: 16),
              ],
            );
          },
            ),
          ],
        ),
    );
  }
}
