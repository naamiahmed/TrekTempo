import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Trip_Person_Type.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';

class BudgetPage extends StatefulWidget {
  final String endPoint;
  const BudgetPage({Key? key, required this.endPoint}) : super(key: key);
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {

  String _budget = 'Low';
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Your Budget',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildRadioCard('Low', 'Low (0-10,000 LKR)', Icons.attach_money, Colors.green),
                  _buildRadioCard('Medium', 'Medium (10,000-25,000 LKR)', Icons.attach_money, Colors.orange),
                  _buildRadioCard('High', 'High (25,000 LKR +)', Icons.attach_money, Colors.red),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Button(
                    text: 'Next',
                    onPressed: () {
                      if (_budget == null) {
                        setState(() {
                          _errorMessage = 'Please select a budget option';
                        });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TripPersonTypePage(endPoint: widget.endPoint, budget: _budget)),
                        );
                      }
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
              groupValue: _budget,
              onChanged: (newValue) {
                setState(() {
                  _budget = newValue.toString();
                  _errorMessage = null; // Clear error message on selection
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}