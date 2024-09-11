import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/InputTextBox.dart';
import 'package:travel_app/Pages/Sign-In-Up/Components/Button.dart';

class TripPlanningPage extends StatefulWidget {
  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _tripNameController = TextEditingController();
  final _startPointController = TextEditingController();
  final _endPointController = TextEditingController();
  
  int _duration = 1; // Duration in days
  int _personCount = 1;
  
  String _budget = 'Low';
  String _tripPersonType = 'Solo';
  String _tripType = 'Spiritual';
  List<String> _selectedInterests = [];

  final List<String> _interestOptions = ['Beach', 'Mountain', 'River', 'Desert'];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
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
                      image: AssetImage('assets/images/TripPlanning.png'), // Replace with correct path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'Plan Your Trip',
                    style: TextStyle(
                      fontSize: 40,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0),
                          offset: Offset(0, 4),
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
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.drive_file_rename_outline, color: Colors.blue),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputTextBox(
                                icon: Icons.trip_origin,
                                label: 'Trip Name',
                                controller: _tripNameController, validator: (String? value) {  },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Starting Point Input
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.green),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputTextBox(
                                icon: Icons.location_on,
                                label: 'Starting Point',
                                controller: _startPointController, validator: (String? value) {  },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Ending Point Input
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_off, color: Colors.red),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputTextBox(
                                icon: Icons.location_on,
                                label: 'Ending Point',
                                controller: _endPointController, validator: (String? value) {  },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Duration Field with Icon and Increment Buttons
                    _buildIncrementSection(
                      title: 'Duration (Days)',
                      icon: Icons.timer,
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

                    // Persons Count Field with Icon and Increment Buttons
                    _buildIncrementSection(
                      title: 'Persons Count',
                      icon: Icons.group,
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

                    // Budget Selection with Radio buttons and Icons
                    const Text('Budget', style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRadioOption('Low', 'Low (0-100\$)', Icons.attach_money),
                        _buildRadioOption('Medium', 'Medium (100\$ - 500\$)', Icons.money),
                        _buildRadioOption('High', 'High (500\$ +)', Icons.monetization_on),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Trip Person Type with icons
                    const Text('Trip Person Type', style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildChoiceChip('Solo', Icons.person),
                        _buildChoiceChip('Couple', Icons.favorite),
                        _buildChoiceChip('Friends', Icons.people),
                        _buildChoiceChip('Family', Icons.family_restroom),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Trip Type with icons
                    const Text('Trip Type', style: TextStyle(fontSize: 18)),
                    Wrap(
                      spacing: 45,
                      children: [
                        _buildChoiceChip('Spiritual', Icons.self_improvement),
                        _buildChoiceChip('Adventure', Icons.hiking),
                        _buildChoiceChip('Historical', Icons.history_edu),
                        _buildChoiceChip('Other', Icons.category),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Interests Selection with filter chips and icons
                    const Text('Interested In', style: TextStyle(fontSize: 18)),
                    Wrap(
                      spacing: 45,
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle form submission
                            print("Trip details submitted");
                          }
                        },
                        buttonColor: Colors.blueAccent,
                        textColor: Colors.white,
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

  // Helper method to build increment/decrement section
  Widget _buildIncrementSection({
    required String title,
    required IconData icon,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 18)),
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
  Widget _buildRadioOption(String value, String label, IconData icon) {
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
        Icon(icon),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }

  // Helper method to build ChoiceChip with icon
  Widget _buildChoiceChip(String label, IconData icon) {
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(icon, color: const Color.fromARGB(255, 71, 71, 71)),
      selected: _tripPersonType == label,
      onSelected: (selected) {
        setState(() {
          _tripPersonType = label;
        });
      },
      selectedColor: Colors.blue.shade300,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    );
  }
}
