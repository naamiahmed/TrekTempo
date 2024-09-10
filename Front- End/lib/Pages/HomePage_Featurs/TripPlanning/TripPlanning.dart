import 'package:flutter/material.dart';
import 'package:travel_app/Pages/PageCommonComponents/TrekTempo_Appbar.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/InputTextBox.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart'; // Import the MainHomePage

class TripPlanningPage extends StatefulWidget {
  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _destinationController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.3, // Adjust the height accordingly
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/TripPlanning.png'), // Replace with the correct path
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'Trip Planning',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextBox(
                      icon: Icons.map,
                      label: 'Trip Name',
                      controller: _tripNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the trip name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.location_on,
                      label: 'Destination',
                      controller: _destinationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the destination';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.date_range,
                      label: 'Start Date',
                      controller: _startDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the start date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.date_range,
                      label: 'End Date',
                      controller: _endDateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the end date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    InputTextBox(
                      icon: Icons.money,
                      label: 'Budget',
                      controller: _budgetController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the budget';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Button(
                        text: 'Submit',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle form submission here
                            print("Trip details submitted");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}