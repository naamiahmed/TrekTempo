import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';

void main() => runApp(AddEvent());

class AddEvent extends StatelessWidget {
  const AddEvent({Key? key}) : super(key: key);
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
  DateTime? _selectedDate; // For one-day events
  DateTimeRange? _dateRange; // For multi-day events
  String _eventType = 'One Day'; // Default event type is 'One Day'
  
  // Image variable
  XFile? _image;

  // Text editing controllers
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  // Function to pick an image
  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage; // Set the selected image
      });
    } else {
      print('No image selected');
    }
  }

  // Function to add event
  Future<void> addEvent(String title, String description, String date, String location, String imageUrl) async {
    final url = Uri.parse('http://localhost:5000/api/addEvent'); // Replace with your actual backend URL

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['date'] = date;
      request.fields['location'] = location;

      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        print('Event added successfully!');
      } else {
        print('Failed to add event: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Function to select a date for one-day events
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Prevent selecting past dates
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
      firstDate: DateTime.now(), // Prevent selecting past dates
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
            Navigator.pop(context);
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
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) return "Event Name can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return "District can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.public),
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
                items: <String>['Colombo', 'Kandy', 'Jaffna', 'Batticaloa', 'Puttalam', 'Trincomalee', 'Galle', 'Matara', 'Hambantota', 'Kurunegala', 'Gampaha', 'Kalutara', 'Kegalle', 'Ratnapura', 'Nuwara Eliya', 'Matale', 'Moneragala', 'Badulla', 'Vavuniya', 'Mannar', 'Kilinochchi', 'Anuradhapura', 'Polonnaruwa', 'Sabaragamuwa']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) return "Place Name can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: 'Place Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: 'Event Location(optional) ',
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
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (_selectedDate == null) {
                          return "Please select a valid event date.";
                        }
                        if (_selectedDate!.isBefore(DateTime.now())) {
                          return "Event date cannot be in the past.";
                        }
                        return null;
                      },
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
                  onTap: () => _selectDateRange(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      validator: (value) {
                        if (_dateRange == null) {
                          return "Please select a valid date range.";
                        }
                        if (_dateRange!.start.isBefore(DateTime.now())) {
                          return "Event start date cannot be in the past.";
                        }
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
                            : '${_dateRange!.start.toLocal()} - ${_dateRange!.end.toLocal()}'.split(' ')[0],
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: pickImage, // Call the pickImage function
                child: Text('Select Image'),
              ),
              // Display the selected image
              if (_image != null) 
                Image.file(File(_image!.path), height: 150, width: 150, fit: BoxFit.cover),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Here you can add your logic to get imageUrl
                    final imageUrl = _image?.path; // Use the image path or implement image upload to get a URL
                    addEvent(
                      _titleController.text,
                      _descriptionController.text,
                      _selectedDate?.toLocal().toString() ?? '',
                      _locationController.text,
                      imageUrl ?? '', // Send the image URL or path
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventPage()),
                    );
                  }
                },
                child: Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}