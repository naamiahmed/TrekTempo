import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';

class AddEventPage extends StatefulWidget {
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
      request.fields['date'] = date;
      request.fields['location'] = location;
      request.fields['place'] = place;
      request.fields['district'] = district ?? '';
      request.fields['description'] = description;  // Ensure correct field name

      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        print('Event added successfully!');
      } else {
        print('Failed to add event: ${response.reasonPhrase}');
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toIso8601String();
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventPage()),
            );
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
                controller: _phoneController,
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
                controller: _placeController,
                validator: (value) {
                  if (value!.isEmpty) return "Place Name can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: 'Place',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                validator: (value) {
                  if (value!.isEmpty) return "Location can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                validator: (value) {
                  if (value!.isEmpty) return "Date can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.date_range),
                  border: OutlineInputBorder(),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value!.isEmpty) return "Description can't be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              // SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addEvent,
                child: Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}