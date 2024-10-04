import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripPlanDetailsPage extends StatefulWidget {
  final String tripId;
  TripPlanDetailsPage({required this.tripId, required tripPlan});

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

          // Displaying trip plan for each day using the custom widget structure
          for (var i = 0; i < tripDetails!['days']; i++) ...[
            TripDayWidget(
              day: i + 1,
              dayPlan: {
                'morning': tripDetails!['places'][i]['morning'],
                'evening': tripDetails!['places'][i]['evening'],
                'night': tripDetails!['places'][i]['night']
              },
            ),
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

class TripDayWidget extends StatelessWidget {
  final int day;
  final Map<String, dynamic> dayPlan;

  TripDayWidget({required this.day, required this.dayPlan});

  @override
  Widget build(BuildContext context) {
    var headline6 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day $day',
              style: Theme.of(context).textTheme.bodyLarge, // Use project theme
            ),
            Divider(),
            buildTimeSection('Morning', dayPlan['morning']),
            Divider(),
            buildTimeSection('Evening', dayPlan['evening']),
            Divider(),
            buildTimeSection('Night', dayPlan['night']),
          ],
        ),
      ),
    );
  }

  Widget buildTimeSection(String timeOfDay, List<dynamic> places) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          timeOfDay,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        ...places.map((place) => buildPlaceWidget(place)).toList(),
      ],
    );
  }

  Widget buildPlaceWidget(Map<String, dynamic> place) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          place['imageUrl'], // URL of place image
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    place['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: Colors.grey,
                  ),
                  Text(
                    place['location'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(place['description']),
              SizedBox(height: 4),
              Text(
                'Weather: ${place['weather']}',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
