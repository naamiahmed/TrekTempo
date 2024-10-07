import 'package:flutter/material.dart';

class TripPlanningPage extends StatefulWidget {
  @override
  _TripPlanningPageState createState() => _TripPlanningPageState();
}

class _TripPlanningPageState extends State<TripPlanningPage> {
  final _formKey = GlobalKey<FormState>();

  String? tripName;
  String? startingPoint;
  String? endingPoint;
  int duration = 1; // Default duration
  int personCount = 1; // Default person count
  String? tripPersonType;
  String? tripType;
  List<String> selectedInterests = [];

  final List<String> interests = [
    'Adventure',
    'Historical',
    'Cultural',
    'Nature',
    'Relaxation'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Planning'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Trip Name'),
                onSaved: (value) {
                  tripName = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a trip name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Starting Point'),
                onSaved: (value) {
                  startingPoint = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the starting point';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ending Point'),
                onSaved: (value) {
                  endingPoint = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ending point';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (days)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  duration = int.tryParse(value!) ?? 1;
                },
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Person Count'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  personCount = int.tryParse(value!) ?? 1;
                },
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Trip Person Type'),
                value: tripPersonType,
                items: ['Solo', 'Couple', 'Family', 'Friends']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    tripPersonType = value;
                  });
                },
                onSaved: (value) {
                  tripPersonType = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a person type';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Trip Type'),
                value: tripType,
                items: ['Adventure', 'Relaxation', 'Cultural', 'Historical']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    tripType = value;
                  });
                },
                onSaved: (value) {
                  tripType = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a trip type';
                  }
                  return null;
                },
              ),
              Text('Select Interests:'),
              Column(
                children: interests
                    .map((interest) => CheckboxListTile(
                          title: Text(interest),
                          value: selectedInterests.contains(interest),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                selectedInterests.add(interest);
                              } else {
                                selectedInterests.remove(interest);
                              }
                            });
                          },
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Generate the prompt based on the form inputs
                    String prompt = generatePrompt(
                      tripName!,
                      startingPoint!,
                      endingPoint!,
                      duration,
                      personCount,
                      tripPersonType!,
                      tripType!,
                      selectedInterests,
                    );

                    // Show the generated prompt
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Generated Prompt'),
                        content: Text(prompt),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generatePrompt(
    String tripName,
    String startingPoint,
    String endingPoint,
    int duration,
    int personCount,
    String tripPersonType,
    String tripType,
    List<String> selectedInterests,
  ) {
    return "Create a trip plan from $startingPoint to $endingPoint, "
        "for a $tripPersonType in a $tripType trip, lasting $duration days "
        "with $personCount person(s). Interests include: ${selectedInterests.join(', ')}.";
  }
}
