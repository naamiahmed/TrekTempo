import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';
import 'package:travel_app/Pages/Destinations/place/weather/weather_card.dart';
import 'package:travel_app/controller/api.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsPage extends StatefulWidget {
  final String city;
  final String direction;
  final List<String> imagePaths;
  final String title;
  final String location;
  final String description;
  final int likes;

  const PlaceDetailsPage({
    super.key,
    required this.city,
    required this.direction,
    required this.imagePaths,
    required this.title,
    required this.location,
    required this.description,
    required this.likes,
  });

  @override
  _PlaceDetailsPageState createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  // bool isLiked = false;
  // bool isSaved = false;
  bool isExpanded = false;
  int likesCount = 0;

  // Weather data variables
  ApiResponse? weatherData;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // likesCount = widget.likes; // Initialize with the passed likes count
    _getWeatherData(placeName: widget.city); // Fetch weather data
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

  // void toggleLike() {
  //   setState(() {
  //     isLiked = !isLiked;
  //     if (isLiked) {
  //       likesCount++;
  //     } else {
  //       likesCount--;
  //     }
  //   });
  // }

  // void toggleSave() {
  //   setState(() {
  //     isSaved = !isSaved;
  //   });
  // }

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
                SizedBox(
                  height: 200.0,
                  width: double.infinity, // get Full width
                  child: AnotherCarousel(
                    images: widget.imagePaths.map((imagePath) {
                      return NetworkImage(imagePath);
                    }).toList(),
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    dotSize: 4.0,
                    dotBgColor:
                        Colors.transparent, // Background color behind the dots
                    indicatorBgPadding: 8.0, // Padding for the indicators
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
                  // Title and Location
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
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

                  // Direction Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          var url =
                              widget.direction; // Replace with your desired URL
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        icon: const Icon(Icons.directions,
                            color: Colors.blueAccent), // Set icon color to blue
                        label: const Text(
                          'Direction',
                          style: TextStyle(
                              color: Colors.blueAccent), // Set text color to blue
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, // Button background color
                          foregroundColor:
                              Colors.blue, // Splash and highlight color
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     IconButton(
                  //       icon: Icon(
                  //         isLiked ? Icons.favorite : Icons.favorite_border,
                  //         color: Colors.red,
                  //         size: 24,
                  //       ),
                  //       onPressed: toggleLike,
                  //     ),
                  //     Text(
                  //       '$likesCount likes',
                  //       style: TextStyle(
                  //         color: Colors.grey[700],
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     IconButton(
                  //       icon: Icon(
                  //         isSaved ? Icons.bookmark : Icons.bookmark_border,
                  //         color: Colors.blue,
                  //       ),
                  //       onPressed: toggleSave,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),

                  // Weather
                  _buildUnderlinedTitle("Weather"),
                  const SizedBox(height: 5),
                  if (weatherData != null) ...[
                    WeatherCard(weatherData: weatherData!),
                  ] else if (errorMessage != null) ...[
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],

                  const SizedBox(height: 16),

                  // Description
                  _buildUnderlinedTitle("Description"),
                  const SizedBox(height: 5),
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
                        color: Colors.blueAccent,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildUnderlinedTitle(String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        width: 40,
        height: 2,
        color: Colors.blueAccent,
      ),
    ],
  );
}
