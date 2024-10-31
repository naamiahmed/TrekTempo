import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';

class Notifications_Home extends StatefulWidget {
  final String userId; // Pass the userId to this widget

  const Notifications_Home({super.key, required this.userId});

  @override
  _Notifications_HomeState createState() => _Notifications_HomeState();
}

class _Notifications_HomeState extends State<Notifications_Home> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await http.get(Uri.parse('http://yourserver.com/api/notifications/${widget.userId}'));

    if (response.statusCode == 200) {
      final List<dynamic> notificationData = jsonDecode(response.body);
      setState(() {
        notifications = notificationData.map((notification) {
          return {
            'title': notification['title'],
            'subtitle': notification['subtitle'],
            'time': notification['time'],
          };
        }).toList();
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainHomePage()));
          },
        ),
        title: const Text('Notification', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600,)),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                notifications.clear();
              });
            },
            child: const Text(
              'Clear all',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
         bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationTile(
            title: notification['title']!,
            subtitle: notification['subtitle']!,
            time: notification['time']!,
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({super.key, 
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHover(true),
      onExit: (_) => _updateHover(false),
      child: Container(
        color: _isHovered ? Colors.grey[200] : Colors.transparent,
        child: ListTile(
          leading: const Icon(Icons.email, color: Colors.black),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          trailing: Text(widget.time),
        ),
      ),
    );
  }

  void _updateHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: Notifications_Home(userId: 'yourUserId'), // Pass the userId here
  ));
}