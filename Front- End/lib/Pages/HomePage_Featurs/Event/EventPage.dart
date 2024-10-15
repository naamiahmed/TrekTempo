import 'package:travel_app/Pages/HomePage_Featurs/Event/AddEvent.dart' as AddEventPage;
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventCard';
import 'package:travel_app/Pages/HomePage_Featurs/Event/EventDetails.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Event/Components/Support.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart'; // Import MainHomePage

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _HomeState();
}

class _HomeState extends State<EventPage> {
  bool csfcover = false, laksapana = false, motor = false;

  final List<Map<String, dynamic>> events = [
    {
      "imagePath": "images/CSF-Cover.png",
      "title": "COLOMBO SHOPPING FESTIVAL - CSF",
      "date": "Dec - 2024 , 05 06 & 07\n10:00 a.m - 10:00 p.m | at BMICH",
      "isSelected": false,
    },
    {
      "imagePath": "images/laksapana.jpeg",
      "title": "Lakshapana waterfall abseiling",
      "date": "Dec - 2024 , 05 06 & 07\n10:00 a.m - 10:00 p.m | at BMICH",
      "isSelected": false,
    },
    {
      "imagePath": "images/motor.jpeg",
      "title": "Colombo Motor Show 2024",
      "date": "Dec - 2024 , 05 06 & 07\n10:00 a.m - 10:00 p.m | at BMICH",
      "isSelected": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainHomePage()),
            );
          },  
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventPage.AddEventPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              "Upcoming Events",
              style: AppWidget.LightTextFeildStyle(),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Column(
                    children: [
                      EventCard(
                        imagePath: event["imagePath"],
                        title: event["title"],
                        date: event["date"],
                        isSelected: event["isSelected"],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details()),
                          );
                          setState(() {
                            for (var e in events) {
                              e["isSelected"] = false;
                            }
                            event["isSelected"] = true;
                          });
                        },
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}