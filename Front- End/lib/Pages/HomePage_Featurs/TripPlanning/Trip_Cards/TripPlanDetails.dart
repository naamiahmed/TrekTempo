import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';
import 'package:travel_app/Pages/Destinations/place/weather/weather_card.dart';
import 'package:travel_app/controller/api.dart';

class TripPlanDetails extends StatefulWidget {
  final String district;
  final List<String> imagePaths;
  final String title;
  final String location;
  final String description;
  final int likes;
  final String locationLink;

  const TripPlanDetails({
    super.key,
    required this.district,
    required this.imagePaths,
    required this.title,
    required this.location,
    required this.description,
    required this.likes,
    required this.locationLink,
  });

  @override
  _PlaceDetailsPageState createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<TripPlanDetails> {
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
    likesCount = widget.likes; // Initialize with the passed likes count
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
                  // const Text("Description",
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold,
                  //     )),
                  // if (weatherData != null) ...[
                  //   WeatherCard(weatherData: weatherData!),
                  // ] else if (errorMessage != null) ...[
                  //   Text(
                  //     errorMessage!,
                  //     style: TextStyle(color: Colors.red),
                  //   ),
                  // ],

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
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                      "View Accommodation place",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                      ),
                    ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
