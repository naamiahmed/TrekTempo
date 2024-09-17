import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripPlanDetailsPage extends StatefulWidget {
  final String tripId;
  TripPlanDetailsPage({required this.tripId});

  @override
  _TripPlanDetailsPageState createState() => _TripPlanDetailsPageState();
}

class _TripPlanDetailsPageState extends State<TripPlanDetailsPage> {
  Map<String, dynamic>? tripDetails;

  @override
  void initState() {
    super.initState();
    fetchTripDetails();
  }

  fetchTripDetails() async {
    final response = await http.get(Uri.parse('http://your-server-address/trip/${widget.tripId}'));
    if (response.statusCode == 200) {
      setState(() {
        tripDetails = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load trip details');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tripDetails == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Trip Plan')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Trip Plan')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Trip Name: ${tripDetails!['tripName']}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text('Duration: ${tripDetails!['days']} days'),
          SizedBox(height: 20),

          // Displaying places for each day
          for (var i = 0; i < tripDetails!['places'].length; i++) ...[
            Text('Day ${i+1} - Places to Visit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(tripDetails!['places'][i], style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
          ],

          // Restaurants
          Text('Recommended Restaurants:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (var restaurant in tripDetails!['restaurants']) ...[
            Text(restaurant, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ],

          // Hotels
          Text('Recommended Hotels:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          for (var hotel in tripDetails!['hotels']) ...[
            Text(hotel, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
          ]
        ],
      ),
    );
  }
}
