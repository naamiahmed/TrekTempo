import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Notification/Notification_Home.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Message/MessagePage.dart';
import 'package:travel_app/Pages/Destinations/districts.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Menu/Menu.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/intro_page.dart';
//import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlanning.dart'; // Import the TripPlanningPage
import 'package:travel_app/Pages/HomePage_Featurs/Translator/TranslationPage.dart'; // Import the TranslationPage
import 'package:travel_app/Pages/HomePage_Featurs/Convertor/CurrencyConverterPage.dart'; // Import the CurrencyConverterPage
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart'; // Import the EventPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    DestinationsPage(),
    SearchPage(),
    MessagesPage(),
    MenuPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MenuPage(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        selectedFontSize: 12,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w300),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Destinations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/naami.jpg'),
          ),
        ),
        title: const Text(
          'Naami Ahmed',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: const Color.fromARGB(255, 80, 46, 46)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifications_Home()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
             Scaffold.of(context).openDrawer(); 
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/MainHome/skydiving.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Create trip plan'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(context, Icons.map, 'Trip Plans', IntroPage()),
                  _buildIconButton(context, Icons.event, 'Events', EventPage()),
                  _buildIconButton(context, Icons.translate, 'Translator', TranslatorPage()),        
                  _buildIconButton(context, Icons.euro, 'Converter', CurrencyConverterPage()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Best Destination',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('View all'),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard('Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                  _buildDestinationCard('Galle Fort', 'assets/images/MainHome/Galle.png'),
                 // _buildDestinationCard('Ella', 'assets/ella.jpg'),
                  _buildDestinationCard('Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                  _buildDestinationCard('Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label, Widget? page) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          onPressed: () {
            if (page != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page),
              );
            }
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildDestinationCard(String title, String imageUrl) {
    return Container(
      width: 160,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Center(child: Text('Search Page')),
    );
  }
}