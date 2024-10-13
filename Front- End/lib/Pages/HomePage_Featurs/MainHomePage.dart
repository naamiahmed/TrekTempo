import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Notification/Notification_Home.dart';
import 'package:travel_app/Pages/Destinations/districts.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Menu/Menu.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Search/search.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/intro_page.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Translator/TranslationPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Convertor/CurrencyConverterPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    const Search(),
    const DestinationsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MenuPage(),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, -0.5), // Shadow direction: bottom to top
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
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
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Destinations',
              ),
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white, // Background color for items
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  final List<String> imageList = [
    'assets/images/MainHome/top_image1.png',
    'assets/images/MainHome/top_image2.png',
    'assets/images/MainHome/top_image3.png',
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    
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
            icon: const Icon(Icons.notifications,
                color: Color.fromARGB(255, 80, 46, 46)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Notifications_Home()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
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
            // Carousel Slider for images
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight * 0.25,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: imageList
                    .map((item) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconButton(
                      context, Icons.map, 'Trip Plans', IntroPage()),
                  _buildIconButton(context, Icons.event, 'Events', const EventPage()),
                  _buildIconButton(
                      context, Icons.translate, 'Translator', const TranslatorPage()),
                  _buildIconButton(context, Icons.euro, 'Converter',
                      const CurrencyConverterPage()),
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
                    child: const Text('View all'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard(
                      'Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                  _buildDestinationCard(
                      'Galle Fort', 'assets/images/MainHome/Galle.png'),
                  // _buildDestinationCard('Ella', 'assets/ella.jpg'),
                  _buildDestinationCard(
                      'Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                  _buildDestinationCard(
                      'Sigiriya', 'assets/images/MainHome/Sigiriya.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context, IconData icon, String label, Widget? page) {
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
      margin: const EdgeInsets.all(8.0),
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
