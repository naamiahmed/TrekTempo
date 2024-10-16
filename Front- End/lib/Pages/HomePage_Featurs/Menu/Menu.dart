import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Profile/ProfilePage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/AboutPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/ContactUsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/shareplus.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignIn.dart';
//import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/SettingsPage.dart'; // Import SettingsPage

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.settings),
                //   title: Text('Settings'),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => SettingsPage()), // Navigate to SettingsPage
                //     );
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.contact_page),
                  title: Text('Contact us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUsPage()),
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
                ListTile(
                  leading: Icon(Icons.support_agent),
                  title: Text('About us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}