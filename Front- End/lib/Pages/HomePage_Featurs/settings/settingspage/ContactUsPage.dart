import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final String email = 'fathimarashidha135@gmail.com';

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=TrekTempo Support&body=Hello, I need help with...', // Add subject and body if needed
    );
    
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Need Help? Contact Us!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'For support or inquiries, feel free to reach out to us at the email below.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            ElevatedButton.icon(
              icon: Icon(Icons.email),
              label: Text('Send an Email'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
              onPressed: _launchEmail,  // Function to open email app
            ),
          ],
        ),
      ),
    );
  }
}
