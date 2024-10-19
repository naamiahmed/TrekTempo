import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'InputDecoration.dart';

class AddAccommodation extends StatefulWidget {
  final String endPoint;
  final String budget;
  const AddAccommodation({Key? key, required this.endPoint, required this.budget}) : super(key: key);

  @override
  _AddAccommodationState createState() => _AddAccommodationState();
}

class _AddAccommodationState extends State<AddAccommodation> {
  final _formKey = GlobalKey<FormState>();
  late String _district;
  String _accommodationType = 'Room';
  String _name = '';
  String _location = '';
  late double _budget;
  String _description = '';
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _district = widget.endPoint;
    _budget = double.tryParse(widget.budget) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Accommodation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: getInputDecoration('District'),
                initialValue: widget.endPoint,
                readOnly: true, // Make the TextFormField read-only
                onChanged: (value) {
                  setState(() {
                    _district = value;
                  });
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _accommodationType,
                decoration: getInputDecoration('Accommodation Type'),
                items: ['Room', 'Villa', 'Apartment', 'Hotel', 'Resort']
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type, style: TextStyle(fontWeight: FontWeight.normal)),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _accommodationType = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an accommodation type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: getInputDecoration('Name'),
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
              SizedBox(height: 16),
              TextFormField(
                decoration: getInputDecoration('Location'),
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
              SizedBox(height: 16),
              TextFormField(
                decoration: getInputDecoration('Budget'),
                keyboardType: TextInputType.number,
                initialValue: widget.budget,
                readOnly: true, // Make the TextFormField read-only
                onChanged: (value) {
                  setState(() {
                    _budget = double.tryParse(value) ?? 0.0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: getInputDecoration('Description'),
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
              SizedBox(height: 20),
              Text('Upload Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imagePath = pickedFile.path;
                    });
                  }
                },
                label: Text('Choose Image'),
                icon: Icon(Icons.image),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );

                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Your Request was Submitted'),
                          content: Text('Thank you for Adding Accommodation, we will Confirm and inform you.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}