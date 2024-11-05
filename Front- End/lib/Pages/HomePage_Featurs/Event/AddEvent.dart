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
  bool _isMultipleDays = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (_isMultipleDays) {
      DateTimeRange? pickedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDateRange != null) {
        setState(() {
          _dateController.text = 
              "${pickedDateRange.start.toLocal().toString().split(' ')[0]} - "
              "${pickedDateRange.end.toLocal().toString().split(' ')[0]}";
        });
      }
    } else {
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

  Future<void> _addEvent() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://localhost:5000/api/addEvent');
      var request = http.MultipartRequest('POST', url);
      
      request.fields.addAll({
        'title': _titleController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
        'place': _placeController.text,
        'district': _selectedDistrict ?? '',
        'description': _descriptionController.text,
      });

      if (_isMultipleDays) {
        final dates = _dateController.text.split(' - ');
        request.fields['dateRange[start]'] = dates[0];
        request.fields['dateRange[end]'] = dates[1];
      } else {
        request.fields['date'] = _dateController.text;
      }

      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _image!.path)
        );
      }

      try {
        final response = await request.send();
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Event added successfully!'))
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const EventPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add event: ${response.reasonPhrase}'))
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'))
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const EventPage()),
          ),
        ),
        title: const Text(
          'Add Event',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                validator: (value) =>
                    value!.isEmpty ? "Event Name can't be empty" : null,
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
                  setState(() => _selectedDistrict = newValue);
                },
                validator: (value) =>
                    value == null || value.isEmpty ? "District can't be empty" : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.public),
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
                items: <String>[
                  'Colombo', 'Kandy', 'Jaffna', 'Batticaloa', 'Puttalam',
                  'Trincomalee', 'Galle', 'Matara', 'Hambantota', 'Kurunegala',
                  'Gampaha', 'Kalutara', 'Kegalle', 'Ratnapura', 'Nuwara Eliya',
                  'Matale', 'Monaragala', 'Badulla', 'Vavuniya', 'Mannar',
                  'Kilinochchi', 'Anuradhapura', 'Polonnaruwa', 'Sabaragamuwa'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _placeController,
                validator: (value) =>
                    value!.isEmpty ? "Place Name can't be empty" : null,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: 'Place',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                validator: (value) =>
                    value!.isEmpty ? "Location can't be empty" : null,
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
                        _dateController.clear();
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                controller: _dateController,
                validator: (value) =>
                    value!.isEmpty ? "Date can't be empty" : null,
                decoration: InputDecoration(
                  labelText: _isMultipleDays ? 'Date Range' : 'Date',
                  prefixIcon: const Icon(Icons.date_range),
                  border: const OutlineInputBorder(),
                ),
                onTap: () => _selectDate(context),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                validator: (value) =>
                    value!.isEmpty ? "Description can't be empty" : null,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              if (_image != null) ...[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}