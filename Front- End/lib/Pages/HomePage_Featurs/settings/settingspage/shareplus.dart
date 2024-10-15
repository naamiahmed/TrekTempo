import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
// Example of the settings page structure
class shareplus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Add other settings options...

          // Share App Feature
          ListTile(
            title: Text('Share App'),
            leading: Icon(Icons.share),
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
