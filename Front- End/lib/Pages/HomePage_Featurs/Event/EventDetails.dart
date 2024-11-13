import 'package:flutter/material.dart';
import 'Components/Support.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic> event;

  const Details({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details', style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,)),
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
        child: Container(
          margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  event["imageUrl"]?.isNotEmpty == true
                      ? event["imageUrl"]
                      : 'https://via.placeholder.com/150',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  event["title"] ?? 'No Title',
                  style: AppWidget.boldTextFieldStyle(),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Description: ",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                    TextSpan(
                      text: event["description"] ?? 'No Description',
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Phone: ",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                    TextSpan(
                      text: event["phone"] ?? 'No Phone',
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "District: ",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                    TextSpan(
                      text: event["district"] ?? 'No District',
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Place: ",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                    TextSpan(
                      text: event["place"] ?? 'No Place',
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
                            RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Date: ",
                      style: AppWidget.semiBooldTextFieldStyle(),
                    ),
                    TextSpan(
                      text: event["date"] != null 
                          ? DateTime.parse(event["date"]).toString().split(' ')[0]
                          : (event["dateRange"] != null
                              ? (event["dateRange"]["end"] != null && event["dateRange"]["end"] != event["dateRange"]["start"])
                                  ? '${DateTime.parse(event["dateRange"]["start"]).toString().split(' ')[0]} - ${DateTime.parse(event["dateRange"]["end"]).toString().split(' ')[0]}'
                                  : '${DateTime.parse(event["dateRange"]["start"]).toString().split(' ')[0]}'
                              : 'No Date'),
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      var location = event["location"]; // Use the location from the event
                      var url = '$location';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.blueAccent,
                    ), // Set icon color to blue
                    label: const Text(
                      'Location',
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
            ],
          ),
        ),
      ),
    );
  }
}