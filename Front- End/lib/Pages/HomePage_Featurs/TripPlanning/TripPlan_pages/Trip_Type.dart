import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripDetails.dart';


class TripTypePage extends StatefulWidget {
  final String endPoint;
  final String budget;
  final String tripPersonType;
  const TripTypePage({super.key, required this.endPoint, required this.budget, required this.tripPersonType});
  @override
  _TripTypePageState createState() => _TripTypePageState();
}

class _TripTypePageState extends State<TripTypePage> {

  String _tripType = 'Spiritual';

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
          'Trip Type',
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
                        MaterialPageRoute(builder: (context) => TripPlanDetails(endPoint: widget.endPoint, budget: widget.budget, tripPersonType: widget.tripPersonType, tripType: _tripType)),
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