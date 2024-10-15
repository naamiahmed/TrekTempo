import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/AboutPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/ContactUsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/OfflineMapSettingsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/SafetyTipsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/SupportPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/shareplus.dart';



class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
     body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
          ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text('ContactUs'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
            );
          },
        ),
          ListTile(
            leading: Icon(Icons.support),
            title: Text('Feedback & Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackSupportPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('OfflineMap'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfflineMapSettingsPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: Text('Safety Tips'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SafetyTipsPage()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => shareplus()),
              );
            },
          ),
          
        ],
      ),
    );
  }
}
    
