import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewAccommodationForm extends StatefulWidget {
  final String userId;

  const NewAccommodationForm({Key? key, required this.userId}) : super(key: key);

  @override
  _NewAccommodationFormState createState() => _NewAccommodationFormState();
}

class _NewAccommodationFormState extends State<NewAccommodationForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  String _name = '';
  String? _district;
  String _description = '';
  String _location = '';
  String? _budget;
  String _locationLink = '';
  String _contact = '';
  int _dayCost = 0;
  String? _imagePath;

  final List<String> _districts = [
    'Ampara', 'Anuradhapura', 'Badulla', 'Batticaloa', 'Colombo', 'Galle',
    'Gampaha', 'Hambantota', 'Jaffna', 'Kalutara', 'Kandy', 'Kegalle',
    'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale', 'Matara', 'Moneragala',
    'Mullaitivu', 'Nuwara Eliya', 'Polonnaruwa', 'Puttalam', 'Ratnapura',
    'Trincomalee', 'Vavuniya'
  ];

  final List<String> _budgets = ['Low', 'Medium', 'High'];

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:5000/api/addAccommodation'),
        );

        // Add all form fields
        request.fields['name'] = _name;
        request.fields['district'] = _district!;
        request.fields['budget'] = _budget!;
        request.fields['location'] = _location;
        request.fields['locationLink'] = _locationLink;
        request.fields['description'] = _description;
        request.fields['contact'] = _contact;
        request.fields['dayCost'] = _dayCost.toString();
        request.fields['userId'] = widget.userId;

        if (_imagePath != null) {
          request.files.add(await http.MultipartFile.fromPath('image', _imagePath!));
        }

        var response = await request.send();

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Accommodation added successfully!')),
          );
          _showSuccessDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add accommodation')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Request was Submitted'),
          content: const Text('Thank you for Adding Accommodation, we will Confirm and inform you.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Return to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Accommodation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                ),
                value: _district,
                items: _districts.map((district) {
                  return DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _district = value),
                validator: (value) => 
                  value == null ? 'Please select a district' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) => setState(() => _description = value),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _location = value),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Budget',
                  border: OutlineInputBorder(),
                ),
                value: _budget,
                items: _budgets.map((budget) {
                  return DropdownMenuItem(
                    value: budget,
                    child: Text(budget),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _budget = value),
                validator: (value) => 
                  value == null ? 'Please select a budget' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location Link',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _locationLink = value),
                validator: (value) => 
                  value?.isEmpty ?? true ? 'Please enter a location link' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => setState(() => _contact = value),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter a contact number';
                  if (value!.length != 10) return 'Contact number must be 10 digits';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Day Cost',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _dayCost = int.tryParse(value) ?? 0),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter day cost';
                  if (int.tryParse(value!) == null) return 'Please enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Select Image'),
                onPressed: _pickImage,
              ),
              if (_imagePath != null) ...[
                const SizedBox(height: 8),
                Image.file(File(_imagePath!), height: 200),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}