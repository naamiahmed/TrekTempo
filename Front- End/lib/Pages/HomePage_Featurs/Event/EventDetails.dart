import 'package:flutter/material.dart';
import 'Components/Support.dart';

class Details extends StatelessWidget {
  final Map<String, dynamic> event;

  const Details({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
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
                text: event["date"] ?? 'No Date',
                style: AppWidget.LightTextFeildStyle(),
                ),
              ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to show the map location
                // For example, you can navigate to a new screen with a map
              },
              child: Text("Show Location"),
            ),
            const SizedBox(height: 20.0),
            Text(
              event["description"] ?? 'No Description',
              style: AppWidget.LightTextFeildStyle(),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}