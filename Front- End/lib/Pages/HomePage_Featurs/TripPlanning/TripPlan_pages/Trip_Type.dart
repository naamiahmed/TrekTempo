import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlanning.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Ready_plan.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';


class TripTypePage extends StatefulWidget {
  @override
  _TripTypePageState createState() => _TripTypePageState();
}

class _TripTypePageState extends State<TripTypePage> {
  String _tripType = 'Spiritual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Trip Type',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildRadioCard('Spiritual', 'Spiritual', Icons.self_improvement, Colors.blue),
                  _buildRadioCard('Adventure', 'Adventure', Icons.explore, Colors.orange),
                  _buildRadioCard('Relaxation', 'Relaxation', Icons.spa, Colors.green),
                  _buildRadioCard('Cultural', 'Cultural', Icons.museum, Colors.purple),
                  const SizedBox(height: 16),
                   Button(
                text: 'Plan Trip',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReadyPlanPage()),
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
              child: Text(label, style: TextStyle(fontSize: 16)),
            ),
            Radio(
              value: value,
              groupValue: _tripType,
              onChanged: (newValue) {
                setState(() {
                  _tripType = newValue.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}