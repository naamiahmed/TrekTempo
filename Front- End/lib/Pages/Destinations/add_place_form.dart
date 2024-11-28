import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:travel_app/controller/placeform_service.dart';

class AddPlaceForm extends StatefulWidget {
  const AddPlaceForm({super.key});

  @override
  _AddPlaceFormState createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends State<AddPlaceForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers for form fields
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<File> _images = [];
  final PlaceService _placeService = PlaceService();

  final List<String> _districts = [
    'Ampara', 'Anuradhapura', 'Badulla', 'Batticaloa', 'Colombo', 'Galle',
    'Gampaha', 'Hambantota', 'Jaffna', 'Kalutara', 'Kandy', 'Kegalle',
    'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale', 'Matara', 'Monaragala',
    'Mullaitivu', 'Nuwara Eliya', 'Polonnaruwa', 'Puttalam', 'Ratnapura',
    'Trincomalee', 'Vavuniya'
  ];

  @override
  void dispose() {
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
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _placeService.createNewPlace(
        placeName: _placeNameController.text,
        district: _districtController.text,
        city: _cityController.text,
        location: _locationController.text,
        direction: _directionController.text,
        description: _descriptionController.text,
        images: _images,
      );

      if (response.statusCode == 201) {
        _showSuccessDialog();
      } else {
        _showErrorDialog('Failed to create place');
      }
    } catch (e) {
      _showErrorDialog('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _placeNameController.clear();
    _districtController.clear();
    _cityController.clear();
    _locationController.clear();
    _directionController.clear();
    _descriptionController.clear();
    setState(() => _images = []);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Place added successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearForm();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        validator: validator ?? (value) {
          if (value?.isEmpty ?? true) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDistrictDropdown() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: _districtController.text.isEmpty ? null : _districtController.text,
        decoration: const InputDecoration(
          labelText: 'District',
          prefixIcon: Icon(Icons.location_city),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: _districts.map((String district) {
          return DropdownMenuItem<String>(
            value: district,
            child: Text(district),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _districtController.text = newValue ?? '';
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'District is required';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Place',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(
                      controller: _placeNameController,
                      label: 'Place Name',
                      icon: Icons.place,
                    ),
                    _buildDistrictDropdown(),
                    _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      icon: Icons.location_on,
                    ),
                    _buildTextField(
                      controller: _locationController,
                      label: 'Location (optional)',
                      icon: Icons.map,
                      validator: null,
                    ),
                    _buildTextField(
                      controller: _directionController,
                      label: 'Direction (optional)',
                      icon: Icons.directions,
                      validator: null,
                    ),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _pickImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Pick Images'),
                    ),
                    const SizedBox(height: 16),
                    if (_images.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _images.map((image) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _images.remove(image);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    else
                      const Center(
                        child: Text(
                          'No images selected',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}