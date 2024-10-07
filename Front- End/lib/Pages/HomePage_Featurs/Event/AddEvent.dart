import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';



class AddEventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddEventPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDistrict;


 DateTime? _selectedDate;        // For one-day events
  DateTimeRange? _dateRange;      // For multi-day events
  String _eventType = 'One Day';  // Default event type is 'One Day'

  // Function to select a single date for one-day events
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Function to select a date range for multi-day events
  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (newDateRange != null) {
      setState(() {
        _dateRange = newDateRange;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back navigation functionality
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(

                      validator: (value)
                      {
                          if(value!.isEmpty)
                          return "Event Name can't be empty";
                          //Event Name is must
                          return null;
                      },

                decoration: InputDecoration(
                  labelText: 'Event Name',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                 validator: (value)
                      {
                          if(value!.isEmpty)
                          return "District can't be empty";
                          //Event Name is must
                          return null;
                      },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.public),
                  labelText: 'District',
                  border: OutlineInputBorder(),
                  
                ),
                items: <String>['Colombo', 'Kandy', 'Jaffna','Batticlo', 'puttalam', 'Trincomale']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextFormField(

                validator: (value)
                      {
                          if(value!.isEmpty)
                          return "Event Location can't be empty";
                          //Event Name is must
                          return null;
                      },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                  labelText: 'Event Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),



             Text('Event Type', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('One Day'),
                      value: 'One Day',
                      groupValue: _eventType,
                      onChanged: (value) {
                        setState(() {
                          _eventType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('More Than One Day'),
                      value: 'More Than One Day',
                      groupValue: _eventType,
                      onChanged: (value) {
                        setState(() {
                          _eventType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Conditional date input based on selected event type
              if (_eventType == 'One Day')
                GestureDetector(
                  onTap: () => _selectDate(context), // Open single date picker
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Event Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? 'Select Date'
                            : '${_selectedDate!.toLocal()}'.split(' ')[0],
                      ),
                    ),
                  ),
                ),
              
              if (_eventType == 'More Than One Day')
                GestureDetector(
                  onTap: () => _selectDateRange(context), // Open date range picker
                  child: AbsorbPointer(
                    child: TextFormField(

                      validator: (value)
                      {
                          if(value!.isEmpty)
                          return "Event Dates can't be empty";
                          //Event Name is must
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Event Dates',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: _dateRange == null
                            ? 'Select Date Range'
                            : '${_dateRange!.start.toLocal()} - ${_dateRange!.end.toLocal()}',
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              TextFormField(
 validator: (value)
                      {
                          if(value!.isEmpty)
                          return "Event Description can't be empty";
                          //Event Name is must
                          return null;
                      },
                
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.attach_file),
                label: Text('Add Document'),
                onPressed: () {
                  // Handle document upload functionality
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Icon(Icons.check_circle, size: 50, color: Colors.green),
                          content: Text(
                            'Thank you for your contribution. After the verification process, we will add the event details on the Event Page.',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
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
}
