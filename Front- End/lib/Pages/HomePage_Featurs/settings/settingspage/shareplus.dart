import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
// Example of the settings page structure
class shareplus extends StatelessWidget {
  const shareplus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
