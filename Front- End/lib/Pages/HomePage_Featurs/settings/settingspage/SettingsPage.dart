import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/AboutPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/ContactUsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/OfflineMapSettingsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/SafetyTipsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/SupportPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/shareplus.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
     body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
          leading: const Icon(Icons.contact_mail),
          title: const Text('ContactUs'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsPage()),
            );
          },
        ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Feedback & Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackSupportPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('OfflineMap'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OfflineMapSettingsPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.app_settings_alt),
            title: const Text('Safety Tips'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SafetyTipsPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const shareplus()),
              );
            },
          ),
          
        ],
      ),
    );
  }
}
    
