import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Profile/EditProfilePage.dart'; // Import the EditProfilePage

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => (MainHomePage()))); // Navigate to the MainHomePage
          },
        ),
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => (EditProfilePage()))); // Navigate to the EditProfilePage
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/naami.jpg'),
            ),
            SizedBox(height: 10),
            const Text(
              'Naami Ahmed',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            const Text(
              'naamiahmed27@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    SizedBox(height: 5),
                    Text('23 likes'),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Icon(Icons.bookmark, color: Colors.grey),
                    SizedBox(height: 5),
                    Text('5 Saved'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset('assets/images/MainHome/Sigiriya.png', fit: BoxFit.cover),
                    Text('Sigiriya'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
