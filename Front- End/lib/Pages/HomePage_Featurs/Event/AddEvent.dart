import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedDistrict;
  File? _image;
  bool _isMultipleDays = false; // Toggle for single/multiple day selection

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected');
    }
  }

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate()) {
      final String title = _titleController.text;
      final String phone = _phoneController.text;
      final String date = _dateController.text;
      final String location = _locationController.text;
      final String place = _placeController.text;
      final String? district = _selectedDistrict;
      final String description = _descriptionController.text;
  
      final url = Uri.parse('http://localhost:5000/api/addEvent');
      var request = http.MultipartRequest('POST', url);
      request.fields['title'] = title;
      request.fields['phone'] = phone;
      request.fields['location'] = location;
      request.fields['place'] = place;
      request.fields['district'] = district ?? '';
      request.fields['description'] = description;
  
      if (_isMultipleDays) {
        final dates = date.split(' - ');
        request.fields['dateRange[start]'] = dates[0];
        request.fields['dateRange[end]'] = dates[1];
      } else {
        request.fields['date'] = date;
      }
  
      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      }
  
      var response = await request.send();
      if (response.statusCode == 201) {
        print('Event added successfully!');
        // Navigate back or show a success message
      } else {
        print('Failed to add event: ${response.reasonPhrase}');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (_isMultipleDays) {
      // Date range picker for multiple days
      DateTimeRange? pickedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDateRange != null) {
        setState(() {
          _dateController.text = "${pickedDateRange.start.toLocal().toString().split(' ')[0]} - ${pickedDateRange.end.toLocal().toString().split(' ')[0]}";
        });
      }
    } else {
      // Single date picker
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null) {
        setState(() {
          _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EventPage()),
            );
          },
        ),
        title: const Text('Add Event',style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,)),
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
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                validator: (value) {
                  if (value!.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Enter a valid 10-digit phone number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
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
                decoration: const InputDecoration(
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _placeController,
                validator: (value) {
                  if (value!.isEmpty) return "Place Name can't be empty";
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: 'Place',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                validator: (value) {
                  if (value!.isEmpty) return "Location can't be empty";
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Multiple Days'),
                  Switch(
                    value: _isMultipleDays,
                    onChanged: (value) {
                      setState(() {
                        _isMultipleDays = value;
                        _dateController.clear(); // Clear the date field when switching
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _dateController,
                validator: (value) {
                  if (value!.isEmpty) return "Date can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: _isMultipleDays ? 'Date Range' : 'Date',
                  prefixIcon: const Icon(Icons.date_range),
                  border: const OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true, // Prevent manual input
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) return "Description can't be empty";
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addEvent,
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}