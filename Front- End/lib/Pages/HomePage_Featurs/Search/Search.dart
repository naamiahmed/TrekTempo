// places of distrcits

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/Place.dart';
import 'package:travel_app/Pages/Destinations/district_places_card.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Place> fetchedPlaces = [];
  List<Place> filteredDestinations = [];
  late Future<String> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchPlacesData();
  }

  Future<String> fetchPlacesData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/getAllPlaces'),
        headers: {},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> placesJson = jsonData['places'];
        for (var placeJson in placesJson) {
          Place place = Place.fromJson(placeJson);
          setState(() {
            fetchedPlaces.add(place);
            filteredDestinations.add(place);
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

  void filterSearch(String query) {
    List<Place> filteredList = [];
    if (query.isNotEmpty) {
      filteredList = fetchedPlaces
          .where((place) =>
              place.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    } else {
      filteredList = fetchedPlaces;
    }

    setState(() {
      filteredDestinations = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MainHomePage();
            }));
          },
        ),
        title: const Text('All Places',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
        backgroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: filterSearch,
              decoration: InputDecoration(
                labelText: 'Search Destination',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          filterSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                filteredDestinations.isEmpty && searchController.text.isNotEmpty
                    ? const Center(
                        child: Text(
                          "No Results Found",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredDestinations.length,
                        itemBuilder: (context, index) {
                          final place = filteredDestinations[index];
                          return Column(
                            children: [
                              PlacesCard(place: place),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
