import 'package:flutter/material.dart';

class SafetyTipsPage extends StatelessWidget {
  final List<Map<String, dynamic>> safetyTips = [
    {
      "icon": Icons.account_circle,
      "tip": "Always carry a copy of your passport and important travel documents."
    },
    {
      "icon": Icons.local_drink,
      "tip": "Stay hydrated and carry bottled water during your travels."
    },
    {
      "icon": Icons.warning,
      "tip": "Be cautious when traveling alone, especially at night."
    },
    {
      "icon": Icons.directions_car,
      "tip": "Use registered taxis or ride-hailing apps to avoid scams."
    },
    {
      "icon": Icons.church,
      "tip": "Respect local customs and dress modestly when visiting temples or religious sites."
    },
    {
      "icon": Icons.lock,
      "tip": "Keep your valuables in a secure place and avoid showing large amounts of cash."
    },
    {
      "icon": Icons.pets,
      "tip": "Be mindful of local wildlife and avoid feeding or disturbing animals."
    },
    {
      "icon": Icons.cloud,
      "tip": "Check the weather forecast and plan your travel accordingly."
    },
    {
      "icon": Icons.phone_android,
      "tip": "Ensure your phone is charged and keep emergency numbers handy."
    },
    {
      "icon": Icons.beach_access,
      "tip": "Follow the guidelines for safety when visiting beaches, especially during the monsoon season."
    },
  ];

  SafetyTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Tips'),
        backgroundColor: Colors.teal, // Customize the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: safetyTips.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                leading: Icon(
                  safetyTips[index]['icon'],
                  color: Colors.teal, // Customize icon color
                  size: 30.0, // Icon size
                ),
                title: Text(
                  safetyTips[index]['tip'],
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
