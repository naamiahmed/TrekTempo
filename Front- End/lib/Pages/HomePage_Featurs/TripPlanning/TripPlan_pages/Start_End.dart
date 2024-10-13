import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/Budget.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/DistrictNameList.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Components/Button.dart';

class StartEndPage extends StatefulWidget {
  @override
  _StartEndPageState createState() => _StartEndPageState();
}

class _StartEndPageState extends State<StartEndPage> {
  final _startPointController = TextEditingController();
  final _endPointController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Future<void> fetchAndNavigate(String endPoint) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('http://localhost:5000/api/getTripPlaces/$endPoint'),
  //       headers: {},
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonData = json.decode(response.body);
  //       List<dynamic> placesJson = jsonData['TripPlaces'];
  //       List<TripPlace> fetchedPlaces = placesJson.map((placeJson) => TripPlace.fromJson(placeJson)).toList();

  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => TripPlaceCard(district: endPoint),
  //         ),
  //       );
  //     } else {
  //       print('Failed to fetch data ${response.body}');
  //     }
  //   } catch (er) {
  //     print(er);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('   ')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Select Trip Type',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                _buildCard(
                  color: Colors.green,
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return itemList.where((String item) {
                        return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      _startPointController.text = selection;
                    },
                    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                      _startPointController.text = textEditingController.text;
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_on),
                          labelText: 'Starting Point',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a starting point';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                _buildCard(
                  color: Colors.red,
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return itemList.where((String item) {
                        return item.toLowerCase().contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) async {
                      _endPointController.text = selection;
 //                     await fetchAndNavigate(selection);
                    },
                    fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                      _endPointController.text = textEditingController.text;
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_on),
                          labelText: 'Ending Point',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an ending point';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Button(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BudgetPage(endPoint:_endPointController.text)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build card with icon
  Widget _buildCard({required Color color, required Widget child}) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}