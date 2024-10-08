import 'package:flutter/material.dart';

class TripPlaceDetailsPage extends StatefulWidget {
  final List<String> imagePaths;
  final String title;
  final String location;
  final String description;
  final int weather;

  const  TripPlaceDetailsPage({
    super.key,
    required this.imagePaths,
    required this.title,
    required this.location,
    required this.description,
    required this.weather,
  });

  @override
  _TripPlaceDetailsPageState createState() => _TripPlaceDetailsPageState();
}

class _TripPlaceDetailsPageState extends State<TripPlaceDetailsPage> {
  bool isLiked = false;
  bool isSaved = false;
  bool isExpanded = false; // Track whether the description is expanded
  int likesCount = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   likesCount = widget.likes; // Initialize with the passed likes count
  // }

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

  //Description toggle
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
            // Stack to overlay the back button on the image
            Stack(
              children: [
                // Adjust image aspect ratio to avoid stretching
                AspectRatio(
                  aspectRatio: 16 / 9, // Standard aspect ratio for images
                  child: Image.network(
                    widget.imagePaths[0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 20, // Move the button closer to the top
                  left: 16, // Align it closer to the left corner
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, // Circular shape
                      color: Colors.black26, // Semi-transparent background
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.location,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: null,
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
                  // const SizedBox(height: 16),

                  //Description
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
                    maxLines: isExpanded ? null : 6, // Show 6 lines or full text
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis, // Handle overflow
                  ),
                  const SizedBox(height: 4), // Small space between text and Read more
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
