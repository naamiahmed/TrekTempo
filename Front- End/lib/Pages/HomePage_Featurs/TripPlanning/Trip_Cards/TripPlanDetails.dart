import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/AccommodationCard.dart';
import 'package:travel_app/controller/api.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/Trip_Cards/TripPlanCard.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/AccommodationDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class TripPlanDetails extends StatefulWidget {
  final String district;
  final List<String> imagePaths;
  final String title;
  final String location;
  final String description;
  final String locationLink;

  const TripPlanDetails({
    super.key,
    required this.district,
    required this.imagePaths,
    required this.title,
    required this.location,
    required this.description,
    required this.locationLink,
  });

  @override
  _TripPlanDetailsState createState() => _TripPlanDetailsState();
}

class _TripPlanDetailsState extends State<TripPlanDetails> {
  bool isLiked = false;
  bool isSaved = false;
  bool isExpanded = false;
  int likesCount = 0;

  // Weather data variables
  ApiResponse? weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _getWeatherData(placeName: widget.district); // Fetch weather data
  }

  // Fetch weather data based on the place name
  _getWeatherData({required String placeName}) async {
    try {
      ApiResponse response = await WeatherApi().getCurrentWeather(placeName);
      setState(() {
        weatherData = response;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likesCount++;
      } else {
        likesCount--;
      }
    });
  }

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  // Description toggle
  void toggleDescription() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Back button
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.imagePaths[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 16,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black26,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16.0, bottom: 16.0, top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(height: 16),

                  // Direction Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          var url = widget.locationLink; // Use the locationLink for direction
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(
                          Icons.directions,
                          color: Colors.blueAccent,
                        ), // Set icon color to blue
                        label: const Text(
                          'Direction',
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ), // Set text color to blue
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button background color
                          foregroundColor: Colors.blue, // Splash and highlight color
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Description
                  const Text("Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                    maxLines: isExpanded ? null : 6,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: toggleDescription,
                    child: Text(
                      isExpanded ? "Read less" : "Read more",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      // Handle tap event
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.blue),
                      //   borderRadius: BorderRadius.circular(8),
                      // ),
                      // child: const Text(
                      //   "View Accommodation place",
                      //   style: TextStyle(
                      //     color: Colors.blue,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // AccommodationCard(
                  //   district: widget.district,
                  //   imagePaths: widget.imagePaths,
                  //   title: widget.title,
                  //   location: widget.location,
                  //   description: widget.description,
                  //   locationLink: widget.locationLink,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}