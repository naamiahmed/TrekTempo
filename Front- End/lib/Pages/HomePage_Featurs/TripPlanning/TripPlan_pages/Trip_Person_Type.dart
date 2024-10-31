import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Trip_Type.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';


class TripPersonTypePage extends StatefulWidget {
  final String endPoint;
  final String budget;
  const TripPersonTypePage({super.key, required this.endPoint, required this.budget});

  @override
  _TripPersonTypePageState createState() => _TripPersonTypePageState();
}

class _TripPersonTypePageState extends State<TripPersonTypePage> {
 
  String _tripPersonType = 'Solo';

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Trip Person Type',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Trip Person Type',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildRadioCard('Solo', 'Solo', Icons.person, Colors.blue),
                  _buildRadioCard('Couple', 'Couple', Icons.favorite, Colors.pink),
                  _buildRadioCard('Family', 'Family', Icons.group, Colors.orange),
                  _buildRadioCard('Friends', 'Friends', Icons.people, Colors.green),
                  const SizedBox(height: 16),
                  Button(
                    text: 'Next',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TripTypePage(endPoint: widget.endPoint, budget: widget.budget, tripPersonType: _tripPersonType)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build radio button with icon
  Widget _buildRadioCard(String value, String label, IconData icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 16)),
            ),
            Radio(
              value: value,
              groupValue: _tripPersonType,
              onChanged: (newValue) {
                setState(() {
                  _tripPersonType = newValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}