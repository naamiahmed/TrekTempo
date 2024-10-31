import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final String email = 'tracktempo.official@gmail.com';

  const ContactUsPage({super.key});

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=TrackTempo Support&body=Hello, I need help with...',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainHomePage()),
            );
          },
        ),
        title: const Text('Contact Us' ,style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,)),
        backgroundColor: Colors.white,
         centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            const Text(
              'Need Help? Contact Us!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'For support or inquiries, feel free to reach out to us at the email below.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              icon: const Icon(Icons.email),
              label: const Text('Send an Email'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
              onPressed: _launchEmail,  // Function to open email app
            ),
          ],
        ),
      ),
    );
  }
}
