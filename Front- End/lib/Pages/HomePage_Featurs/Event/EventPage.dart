import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import the dart:async package
import 'package:travel_app/Pages/HomePage_Featurs/Event/AddEvent.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventCard';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'EventDetails.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _HomeState();
}

class _HomeState extends State<EventPage> {
  List events = [];
  Timer? _timer; // Declare a Timer

  @override
  void initState() {
    super.initState();
    fetchEvents();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchEvents(); // Fetch events every 30 seconds
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> fetchEvents() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/getAllAcceptedEvents'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List fetchedEvents = responseData['events'];
        setState(() {
          events = fetchedEvents;
        });
      } else {
        print('Failed to load events: ${response.statusCode}');
        throw Exception('Failed to load events');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainHomePage()),
            );
          },
        ),
        title: const Text('Events', style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEventPage(),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: events.isEmpty
          ? const Center(
              child: Text(
                "No Events Found",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Column(
                  children: [
                    EventCard(
                      title: event["title"] ?? 'No Title',
                      phone: event["phone"] ?? 'No Phone',
                      district: event["district"] ?? 'No District',
                      place: event["place"] ?? 'No Place',
                      location: event["location"] ?? 'No Location',
                      date: event["date"] ?? 'No Date',
                      imageUrl: event["imageUrl"] ?? 'https://via.placeholder.com/150',
                      isSelected: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Details(event: event),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                );
              },
            ),
    );
  }
}