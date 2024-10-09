import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripDetails.dart'; // Replace with your actual next page import
import 'package:travel_app/pages/Destinations/show_district_places.dart';
class ReadyPlanPage extends StatefulWidget {
  @override
  _ReadyPlanPageState createState() => _ReadyPlanPageState();
}

class _ReadyPlanPageState extends State<ReadyPlanPage> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds and then navigate to the next page
    Future.delayed(Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => TripPlanDetails()), // Replace with your actual next page
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Your trip is creating, please wait...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}