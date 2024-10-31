import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
// Example of the settings page structure
class shareplus extends StatelessWidget {
  const shareplus({super.key});

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
        title: const Text('Settings',style: TextStyle(
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
      body: ListView(
        children: [
          // Add other settings options...

          // Share App Feature
          ListTile(
            title: const Text('Share App'),
            leading: const Icon(Icons.share),
            onTap: () {
              _shareApp(); // Call the share function when tapped
            },
          ),
        ],
      ),
    );
  }

  // Define the share function
  void _shareApp() {
    Share.share(
      'Google Play: WhatsApp on Google Play\n',
      
      subject: 'Download the TrekTempo Travel App!'
    );
  }

  
}
