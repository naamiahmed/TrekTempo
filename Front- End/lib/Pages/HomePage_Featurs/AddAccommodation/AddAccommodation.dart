// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'InputDecoration.dart';

// class AddAccommodation extends StatefulWidget {
//   final String endPoint;
//   final String budget;
//   const AddAccommodation({super.key, required this.endPoint, required this.budget});

//   @override
//   _AddAccommodationState createState() => _AddAccommodationState();
// }

// class _AddAccommodationState extends State<AddAccommodation> {
//   final _formKey = GlobalKey<FormState>();
//   late String _district;
//   final String _accommodationType = 'Room';
//   String _name = '';
//   String _location = '';
//   String _locationLink = '';
//   late String _budget;
//   String _description = '';
//   String? _imagePath;

//   @override
//   void initState() {
//     super.initState();
//     _district = widget.endPoint;
//     _budget = widget.budget;
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Processing Data')),
//       );

//       try {
//         var request = http.MultipartRequest(
//           'POST',
//           Uri.parse('http://localhost:5000/api/addAccommodation'),
//         );

//         request.fields['name'] = _name;
//         // request.fields['tripPersonType'] = 'Solo'; // Example value
//         request.fields['district'] = _district;
//         request.fields['budget'] = _budget;
//         // request.fields['tripType'] = _accommodationType;
//         request.fields['location'] = _location;
//         request.fields['locationLink'] = _locationLink; 
//         request.fields['description'] = _description;

//         if (_imagePath != null) {
//           request.files.add(await http.MultipartFile.fromPath('image', _imagePath!));
//         }

//         var response = await request.send();

//         if (response.statusCode == 201) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Accommodation added successfully!')),
//           );
//           print('Accommodation added successfully');
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Failed to add accommodation')),
//           );
//           print('Failed to add accommodation: ${await response.stream.bytesToString()}');
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }

//       // Show confirmation dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Your Request was Submitted'),
//             content: const Text('Thank you for Adding Accommodation, we will Confirm and inform you.'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Accommodation'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: <Widget>[
//               TextFormField(
//                 decoration: getInputDecoration('District'),
//                 initialValue: widget.endPoint,
//                 readOnly: true, // Make the TextFormField read-only
//                 onChanged: (value) {
//                   setState(() {
//                     _district = value;
//                   });
//                 },
//               ),
//               // SizedBox(height: 16),
//               // DropdownButtonFormField<String>(
//               //   value: _accommodationType,
//               //   decoration: getInputDecoration('Accommodation Type'),
//               //   items: ['Room', 'Villa', 'Apartment', 'Hotel', 'Resort']
//               //       .map((type) => DropdownMenuItem<String>(
//               //             value: type,
//               //             child: Text(type, style: TextStyle(fontWeight: FontWeight.normal)),
//               //           ))
//               //       .toList(),
//               //   onChanged: (value) {
//               //     setState(() {
//               //       _accommodationType = value!;
//               //     });
//               //   },
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please select an accommodation type';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: getInputDecoration('Name'),
//                 onChanged: (value) {
//                   setState(() {
//                     _name = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//               ),


//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: getInputDecoration('City Name'),
//                 onChanged: (value) {
//                   setState(() {
//                     _location = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your city name';
//                   }
//                   return null;
//                 },
//               ),


//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: getInputDecoration('Location Link'),
//                 onChanged: (value) {
//                   setState(() {
//                     _locationLink = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a location Link';
//                   }
//                   return null;
//                 },
//               ),


//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: getInputDecoration('Budget'),
//                 initialValue: widget.budget,
//                 readOnly: true, // Make the TextFormField read-only
//                 onChanged: (value) {
//                   setState(() {
//                     _budget = widget.budget;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a budget';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: getInputDecoration('Description'),
//                 maxLines: 5,
//                 onChanged: (value) {
//                   setState(() {
//                     _description = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               const Text('Upload Image', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               ElevatedButton.icon(
//                 onPressed: () async {
//                   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//                   if (pickedFile != null) {
//                     setState(() {
//                       _imagePath = pickedFile.path;
//                     });
//                   }
//                 },
//                 label: const Text('Choose Image'),
//                 icon: const Icon(Icons.image),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//               if (_imagePath != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0),
//                   child: Image.file(
//                     File(_imagePath!),
//                     height: 200,
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }