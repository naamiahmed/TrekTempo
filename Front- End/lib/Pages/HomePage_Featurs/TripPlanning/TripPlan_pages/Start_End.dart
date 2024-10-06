import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Budget.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/DistrictNameList.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';

class StartEndPage extends StatelessWidget {
  var _startPointController = TextEditingController();
  var _endPointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  const Text(
                    'Select Trip Type',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),
            _buildCard(
  color: Colors.green,
  child: Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      // If the input field is empty, return no options
      if (textEditingValue.text.isEmpty) {
        return const Iterable<String>.empty();
      }
      // Return suggestions based on user input
      return itemList.where((String item) {
        return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
      });
    },
    onSelected: (String selection) {
      // Set the selected value to the controller
      _startPointController.text = selection;
    },
    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
      // Assign the controller for the autocomplete widget
      _startPointController = textEditingController;

      // Create a TextField with a label and icon
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          icon: Icon(Icons.location_on), // Location icon
          labelText: 'Starting Point', // Label for the field
          errorText: _startPointController.text.isEmpty ? 'Please enter a starting point' : null, // Error message
        ),
      );
    },
  ),
),

                    const SizedBox(height: 8),

                    // Ending Point Input

_buildCard(
  color: Colors.red,
  child: Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      // If the input field is empty, return no options
      if (textEditingValue.text.isEmpty) {
        return const Iterable<String>.empty();
      }
      // Return suggestions based on user input
      return itemList.where((String item) {
        return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
      });
    },
    onSelected: (String selection) {
      // Set the selected value to the controller
      _endPointController.text = selection;
    },
    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
      // Assign the controller for the autocomplete widget
      _endPointController = textEditingController;

      // Create a TextField with a label and icon
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          icon: Icon(Icons.location_on), // Location icon
          labelText: 'Ending Point', // Label for the field
          errorText: _endPointController.text.isEmpty ? 'Please enter an ending point' : null, // Error message
        ),
      );
    },
  ),
),
    const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BudgetPage()),
                  );
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build card with icon
Widget _buildCard({required Color color, required Widget child}) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

}