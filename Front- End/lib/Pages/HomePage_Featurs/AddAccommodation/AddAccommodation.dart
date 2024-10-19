import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
                decoration: InputDecoration(labelText: 'District'),
                keyboardType: TextInputType.number,
                initialValue: widget.endPoint,
                enabled:false, // Disable the TextFormField

                onChanged: (value) {
                  setState(() {
                    _district = (double.tryParse(value)) as String;
                  });
                },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter a District';
                //   }
                //   if (double.tryParse(value) == null) {
                //     return 'Please enter a valid number';
                //   }
                //   return null;
                // },
              ),
              DropdownButtonFormField<String>(
                value: _accommodationType,
                decoration: InputDecoration(labelText: 'Accommodation Type'),
                items: ['Room', 'Villa', 'Apartment', 'Hotel', 'Resort']
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
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
                TextFormField(
                decoration: InputDecoration(labelText: 'Budget'),
                keyboardType: TextInputType.number,
                initialValue: widget.budget,
                enabled:false, // Disable the TextFormField
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
              SizedBox(height: 20),
              Text('Upload Image', style: TextStyle(fontSize: 16)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}