import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

class AddPlaceForm extends StatefulWidget {
  @override
  _AddPlaceFormState createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends State<AddPlaceForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<File> _images = [];

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _placeNameController.dispose();
    _districtController.dispose();
    _cityController.dispose();
    _locationController.dispose();
    _directionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _images = pickedFiles.map((file) => File(file.path)).toList();
    });
    }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form data
      final placeName = _placeNameController.text;
      final district = _districtController.text;
      final city = _cityController.text;
      final location = _locationController.text;
      final direction = _directionController.text;
      final description = _descriptionController.text;

      // Create a multipart request for image uploads
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:5000/api/createNewPlace'),
      );

      // Add form fields
      request.fields.addAll({
        'name': placeName,
        'district': district,
        'city': city,
        'location': location,
        'direction': direction,
        'description': description,
      });

      // Attach images to the request
      for (File image in _images) {
        String fileName = basename(image.path);
        request.files.add(
          await http.MultipartFile.fromPath('images', image.path, filename: fileName),
        );
      }

      try {
        // Send the request
        var response = await request.send();

        if (response.statusCode == 201) {
          // Show success dialog
          _showSuccessDialog();
        } else {
          print('Failed to create the place. Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error occurred: $e');
      }

      // Clear the form fields
      _formKey.currentState!.reset();
      setState(() {
        _images = [];
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Submission Successful'),
          content: const Text('Your place has been submitted and is under review.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      validator: validator,
      maxLines: maxLines,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _placeNameController,
                labelText: 'Place Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place name';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _districtController,
                labelText: 'District',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the district';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _cityController,
                labelText: 'City',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the city';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _locationController,
                labelText: 'Location (optional)',
              ),
              _buildTextField(
                controller: _directionController,
                labelText: 'Direction (optional)',
              ),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImages,
                child: const Text('Pick Images'),
              ),
              const SizedBox(height: 10),
              _images.isNotEmpty
                  ? Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _images.map((image) {
                        return Stack(
                          children: [
                            Image.file(
                              image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _images.remove(image);
                                  });
                                },
                                child: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    )
                  : const Text('No images selected'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddPlaceForm(),
  ));
}