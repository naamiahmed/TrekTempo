import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewAccommodationForm extends StatefulWidget {
  @override
  _NewAccommodationFormState createState() => _NewAccommodationFormState();
}

class _NewAccommodationFormState extends State<NewAccommodationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _district;
  String _name = '';
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

        request.fields['name'] = _name;
        request.fields['district'] = _district!;
        request.fields['budget'] = _budget!;
        request.fields['location'] = _location;
        request.fields['locationLink'] = _locationLink;
        request.fields['description'] = _description;
        request.fields['contact'] = _contact;
        request.fields['dayCost'] = _dayCost.toString();

        if (_imagePath != null) {
          request.files.add(await http.MultipartFile.fromPath('image', _imagePath!));
        }

        var response = await request.send();

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Accommodation added successfully!')),
          );
          print('Accommodation added successfully');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add accommodation')),
          );
          print('Failed to add accommodation: ${await response.stream.bytesToString()}');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }

      // Show confirmation dialog
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
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Accommodation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'District'),
                value: _district,
                items: _districts.map((district) {
                  return DropdownMenuItem(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _district = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a district';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location'),
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Budget'),
                value: _budget,
                items: _budgets.map((budget) {
                  return DropdownMenuItem(
                    value: budget,
                    child: Text(budget),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _budget = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a budget';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Link'),
                onChanged: (value) {
                  setState(() {
                    _locationLink = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  setState(() {
                    _contact = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length != 10) {
                    return 'Please enter a valid 10-digit contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Day Cost'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _dayCost = int.tryParse(value) ?? 0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid day cost';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text('Upload Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                },
                label: const Text('Choose Image'),
                icon: const Icon(Icons.image),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              if (_imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.file(
                    File(_imagePath!),
                    height: 200,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}