import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/InputTextBox.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/DistrictNameList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripPlanningPage extends StatefulWidget {
  const TripPlanningPage({super.key});

  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  int _duration = 1; // Duration in days
  int _personCount = 1;
  String _budget = 'Low';
  String _tripPersonType = 'Solo';
  String _tripType = 'Spiritual';
  final List<String> _selectedInterests = [];

  final List<String> _interestOptions = ['Beach', 'Mountain', 'River', 'Desert'];

  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  var _startPointController = TextEditingController();
  var _endPointController = TextEditingController();

  Future<void> _submitTrip() async {
  if (_formKey.currentState!.validate()) {
    final tripDetails = {
      'tripName': _tripNameController.text,
      'startingPoint': _startPointController.text,
      'endingPoint': _endPointController.text,
      'days': _duration,
      'places': _selectedInterests,
      'restaurants': [], // Add restaurant data if available
      'hotels': [] // Add hotel data if available
    };

    try {
      final response = await http.post(
        Uri.parse('http://your-server-address/trip/save'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tripDetails),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final tripId = responseData['tripId'];

        // Success: Use the server response (e.g., tripId)
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TripPlanDetails( ),
        //   ),
        // );
      } else {
        // Error but still navigate to TripPlanDetails with empty tripId
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TripPlanDetails( ),
        //   ),
        // );
      }
    } catch (e) {
      // Handle connection or other errors, still navigate to TripPlanDetails
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => TripPlanDetails( ),
      //   ),
      // );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image (Header with title)
            Stack(
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/With_TrekTempo.png'), // Replace with correct path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: 40,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0),
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trip Name Input with icon
                    _buildCard(
                      color: Colors.blue,
                      child: InputTextBox(
                        icon: Icons.trip_origin,
                        label: 'Trip Name',
                        controller: _tripNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a trip name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Starting Point Input
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
          icon: const Icon(Icons.location_on), // Location icon
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
          icon: const Icon(Icons.location_on), // Location icon
          labelText: 'Ending Point', // Label for the field
          errorText: _endPointController.text.isEmpty ? 'Please enter an ending point' : null, // Error message
        ),
      );
    },
  ),
),

                    const SizedBox(height: 16),

                    // Duration Field with Icon and Increment Buttons
                    _buildIncrementSection(
                      title: 'Duration (Days)',
                      value: _duration,
                      onDecrement: () {
                        setState(() {
                          if (_duration > 1) _duration--;
                        });
                      },
                      onIncrement: () {
                        setState(() {
                          _duration++;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Budget Selection with Radio buttons and Icons
                    const Text('Budget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildRadioOption('Low', 'Low (0-100\$)'),
                        _buildRadioOption('Medium', 'Medium (100\$ - 500\$)'),
                        _buildRadioOption('High', 'High (500\$ +)'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Trip Person Type with icons
                    const Text('Trip Person Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChoiceChip('Solo', Icons.person),
                        _buildChoiceChip('Couple', Icons.favorite),
                        _buildChoiceChip('Friends', Icons.people),
                        _buildChoiceChip('Family', Icons.family_restroom),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Show Persons Count Field only if Friends or Family is selected
                    if (_tripPersonType == 'Friends' || _tripPersonType == 'Family')
                      _buildPersonIncrementSection(
                        title: 'Persons Count',
                        value: _personCount,
                        onDecrement: () {
                          setState(() {
                            if (_personCount > 1) _personCount--;
                          });
                        },
                        onIncrement: () {
                          setState(() {
                            _personCount++;
                          });
                        },
                      ),
                    const SizedBox(height: 16),

                    // Trip Type with icons
                    const Text('Trip Type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildTripType('Spiritual', Icons.self_improvement),
                        _buildTripType('Adventure', Icons.hiking),
                        _buildTripType('Historical', Icons.history_edu),
                        _buildTripType('Other', Icons.category),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Interests Selection with filter chips and icons
                    const Text('Interested In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _interestOptions.map((interest) {
                        return FilterChip(
                          avatar: Icon(
                            interest == 'Beach'
                                ? Icons.beach_access
                                : interest == 'Mountain'
                                    ? Icons.terrain
                                    : interest == 'River'
                                        ? Icons.water
                                        : Icons.landscape,
                            color: const Color.fromARGB(255, 63, 63, 63),
                          ),
                          label: Text(interest),
                          selected: _selectedInterests.contains(interest),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedInterests.add(interest);
                              } else {
                                _selectedInterests.remove(interest);
                              }
                            });
                          },
                          selectedColor: Colors.blue.shade300,
                          checkmarkColor: Colors.white,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Submit Button with Elevation and color
                    Center(
                      child: Button(
                        text: 'Submit',
                        onPressed: _submitTrip,
                        textColor: Colors.white,
                        buttonColor: Colors.blueAccent,
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

  // Helper method to build increment/decrement section
  Widget _buildIncrementSection({
    required String title,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 0),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onDecrement,
            ),
            Text('$value', style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build person increment/decrement section
  Widget _buildPersonIncrementSection({
    required String title,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onDecrement,
            ),
            Text('$value', style: const TextStyle(fontSize: 18)),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build radio button with icon
  Widget _buildRadioOption(String value, String label) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: _budget,
          onChanged: (newValue) {
            setState(() {
              _budget = newValue.toString();
            });
          },
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  // Helper method to build ChoiceChip with icon
  Widget _buildChoiceChip(String label, IconData icon) {
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(icon, color: const Color.fromARGB(255, 12, 38, 92)),
      selected: _tripPersonType == label,
      onSelected: (selected) {
        setState(() {
          _tripPersonType = label;
        });
      },
    );
  }

  // Helper method to build TripType with icon
  Widget _buildTripType(String label, IconData icon) {
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(icon, color: const Color.fromARGB(255, 71, 71, 71)),
      selected: _tripType == label,
      onSelected: (selected) {
        setState(() {
          _tripType = label;
        });
      },
    );
  }
}