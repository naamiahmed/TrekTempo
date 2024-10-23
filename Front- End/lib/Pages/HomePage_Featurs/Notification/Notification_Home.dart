import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        title: const Text('Notification', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
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

  const NotificationTile({
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
          leading: Icon(Icons.email, color: Colors.black),
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
  runApp(MaterialApp(
    home: Notifications_Home(userId: 'yourUserId'), // Pass the userId here
  ));
}