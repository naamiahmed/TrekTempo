import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_app/Pages/Destinations/place/showing_place_details.dart';
import 'package:travel_app/Pages/HomePage_Featurs/AddAccommodation/accomadation.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Notification/Notification_Home.dart';
import 'package:travel_app/Pages/Destinations/districts.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Menu/Menu.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Profile/ProfilePage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Search/search.dart';
import 'package:travel_app/Pages/HomePage_Featurs/TripPlanning/TripPlan_pages/intro_page.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Translator/TranslationPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Convertor/CurrencyConverterPage.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/Models/User.dart';
import 'package:travel_app/Models/Place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Search(),
    const AccommodationPage(),
    const DestinationsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
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
                icon: Icon(Icons.hotel_class),
                label: 'Accommodation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Destinations',
              ),
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'assets/images/MainHome/top_image1.png',
    'assets/images/MainHome/top_image2.png',
    'assets/images/MainHome/top_image3.png',
    'assets/images/MainHome/123.jpg',
  ];

  String? userId;
  Future<User>? futureProfile;
  Future<List<Place>>? futureTopPlaces;

  @override
  void initState() {
    super.initState();
    loadUserId();
    futureTopPlaces = fetchTopPlaces();
  }

  Future<User> fetchProfileData(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/auth/getProfile/$userId'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['user'] != null) {
          return User.fromJson(jsonData['user']);
        } else {
          throw Exception('Failed to load user profile');
        }
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });

    if (userId != null) {
      futureProfile = fetchProfileData(userId ?? "6700ae680edbeca3aef3e1e5");
    } else {
      // print('No userId found in SharedPreferences');
    }
  }

  Future<List<Place>> fetchTopPlaces() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/getTopPlaces'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        List<dynamic> placesJson = jsonData['places'];

        return placesJson
            .map((placeJson) => Place.fromJson(placeJson))
            .toList();
      } else {
        throw Exception('Failed to load top places');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage())); // or use Navigator.push with MaterialPageRoute
              },
              child: FutureBuilder<User>(
                future: futureProfile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png')),
                    );
                  } else if (snapshot.hasError) {
                    return const Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png')),
                    );
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: CircleAvatar(
                        backgroundImage: user.profilePicURL != null &&
                                user.profilePicURL!.isNotEmpty
                            ? NetworkImage(user.profilePicURL!)
                            : const NetworkImage(
                                'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png'),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding:
                          EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png'),
                      ),
                    );
                  }
                },
              ),
            ),
            title: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage())); // or use Navigator.push with MaterialPageRoute
              },
              child: FutureBuilder<User>(
                future: futureProfile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(color: Colors.black),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error',
                      style: TextStyle(color: Colors.black),
                    );
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Text(
                      user.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const Text(
                      'No Name',
                      style: TextStyle(color: Colors.black),
                    );
                  }
                },
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications_Home(
                              userId: '',
                            )),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
            iconTheme: const IconThemeData(
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
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

            // Feature Buttons
// Feature Buttons
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                children: [
                  // First row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const IntroPage()),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map,
                                      size: 24, color: Colors.black),
                                  SizedBox(width: 15),
                                  Text('Trip Plans',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EventPage()),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.event,
                                      size: 24, color: Colors.black),
                                  SizedBox(width: 15),
                                  Text('Events',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Second row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TranslatorPage()),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.translate,
                                      size: 24, color: Colors.black),
                                  SizedBox(width: 15),
                                  Text('Translator',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CurrencyConverterPage()),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.euro,
                                      size: 24, color: Colors.black),
                                  SizedBox(width: 15),
                                  Text('Converter',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Most Fevourite Places By Likes
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Most Fevourite Places',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            FutureBuilder<List<Place>>(
              future: futureTopPlaces,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue, // Change color to blue
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text('No places found.'));
                } else if (snapshot.hasData) {
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final place = snapshot.data![index];
                        return _buildDestinationCard(place);
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationCard(Place place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceDetailsPage(place: place),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(place.images[0]),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  place.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Column(
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  Text(
                    '${place.likes}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
