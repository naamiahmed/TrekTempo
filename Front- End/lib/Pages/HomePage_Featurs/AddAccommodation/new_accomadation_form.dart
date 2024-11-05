import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewAccommodationForm extends StatefulWidget {
  final String userId;
  const NewAccommodationForm({super.key, required this.userId});

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
    'Kilinochchi', 'Kurunegala', 'Mannar', 'Matale', 'Matara', 'Monaragala',
    'Mullaitivu', 'Nuwara Eliya', 'Polonnaruwa', 'Puttalam', 'Ratnapura',
    'Trincomalee', 'Vavuniya'
  ];

  final List<String> _budgets = ['Low', 'Medium', 'High'];

  Future<void> _submitForm() async {
    if (_imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:5000/api/addAccommodation'),
        );

        request.fields.addAll({
          'name': _name,
          'district': _district!,
          'budget': _budget!,
          'location': _location,
          'locationLink': _locationLink,
          'description': _description,
          'contact': _contact,
          'dayCost': _dayCost.toString(),
          'userId': widget.userId,
        });

        if (_imagePath != null) {
          request.files.add(await http.MultipartFile.fromPath('image', _imagePath!));
        }

        var response = await request.send();

        if (response.statusCode == 201) {
          _showSuccessDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add accommodation'), backgroundColor: Colors.red,),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red,),
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
          content: const Text('Thank you for Adding Accommodation, we will confirm and inform you.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context)
                  ..pop()
                  ..pop();
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
        title: const Text('Add Accommodation',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600
          )
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                validator: (value) => value == null ? 'Please select a district' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _name = value),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                onChanged: (value) => setState(() => _description = value),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _location = value),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a location' : null,
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
                validator: (value) => value == null ? 'Please select a budget' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location Link',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _locationLink = value),
                validator: (value) => value?.isEmpty ?? true ? 'Please enter a location link' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => setState(() => _contact = value),
                validator: (value) => (value?.length ?? 0) != 10 ? 'Please enter a valid 10-digit number' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Day Cost',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() => _dayCost = int.tryParse(value) ?? 0),
                validator: (value) => int.tryParse(value ?? '') == null ? 'Please enter a valid number' : null,
              ),
              const SizedBox(height: 16),
              const Text('Upload Image *', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() => _imagePath = pickedFile.path);
                  }
                },
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text('Choose Image', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              if (_imagePath != null) ...[
                const SizedBox(height: 16),
                Image.file(File(_imagePath!), height: 200),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Submit', 
                  style: TextStyle(color: Colors.white, fontSize: 18)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}