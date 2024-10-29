import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travel_app/Models/Accommodation.dart';
import 'package:travel_app/Pages/HomePage_Featurs/AddAccommodation/AddAccommodation.dart';
import 'package:travel_app/Pages/HomePage_Featurs/AddAccommodation/accomadation_card.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';

class AccommodationPage extends StatefulWidget {
  const AccommodationPage({super.key});

  @override
  State<AccommodationPage> createState() => _AccommodationPageState();
}

class _AccommodationPageState extends State<AccommodationPage> {
  Future<List<Accommodation>>? futureAccommodations;
  String? selectedDistrict;
  String? selectedBudget;

 final List<String> districts = [
  'Ampara', 'Anuradhapura', 'Badulla', 'Batticaloa', 'Colombo', 'Galle',
  'Gampaha', 'Hambantota', 'Jaffna', 'Kalutara', 'Kandy', 'Kegalle',
  'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale', 'Matara', 'Moneragala',
  'Mullaitivu', 'Nuwara Eliya', 'Polonnaruwa', 'Puttalam', 'Ratnapura',
  'Trincomalee', 'Vavuniya'
];


  final List<String> budgetRanges = ['Low', 'Medium', 'High'];

  @override
  void initState() {
    super.initState();
    futureAccommodations = fetchAccommodationsData();
  }

  Future<List<Accommodation>> fetchAccommodationsData() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/getAccommodation/${selectedDistrict ?? ''}/${selectedBudget ?? ''}'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> accommodationsJson = jsonData['accommodations'];

        return accommodationsJson
            .map((accommodationJson) => Accommodation.fromJson(accommodationJson))
            .toList();
      } else {
        throw Exception('Failed to load accommodations');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  void _onSearch() {
    setState(() {
      futureAccommodations = fetchAccommodationsData();
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
        title: const Text('Accommodations',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const AddAccommodation()),
              // );
            },
          ),
        ],
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select District',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        value: selectedDistrict,
                        items: districts.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Row(
                              children: [
                                Text(
                                  district,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDistrict = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Select Budget',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                        value: selectedBudget,
                        items: budgetRanges.map((String budget) {
                          return DropdownMenuItem<String>(
                            value: budget,
                            child: Row(
                              children: [
                                Text(
                                  budget,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBudget = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: _onSearch,
                    child: const Text('Search'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Accommodation>>(
              future: futureAccommodations,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.blueAccent,
                    size: 50,
                  ));
                } else if (snapshot.hasError) {
                  // Show an empty container or a specific message indicating no data is available
                  return const Center(child: Text('No data available.'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text('No accommodations found.'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final accommodation = snapshot.data![index];
                      return Column(
                        children: [
                          AccommodationCard(accommodation: accommodation),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}