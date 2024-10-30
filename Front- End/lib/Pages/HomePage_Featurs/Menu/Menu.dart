import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Profile/ProfilePage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/AboutPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/ContactUsPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/settings/settingspage/shareplus.dart';
import 'package:travel_app/Pages/Sign-In-Up/SignIn.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  leading: const Icon(Icons.person),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_page),
                  title: const Text('Contact us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ContactUsPage()),
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
                ListTile(
                  leading: const Icon(Icons.support_agent),
                  title: const Text('About us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // Clear session data
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              // Navigate to SignInPage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}