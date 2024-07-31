import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Notification/MessagePage.dart';

class Notifications_Home extends StatelessWidget {
  const Notifications_Home({super.key});

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
              // Handle clear all action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              );
            },
            child: const Text(
              'Clear all',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: const [
          NotificationTile(
            title: 'New Event Update',
            subtitle: 'A camping event organized by TrackTempo',
            time: 'Sun,12:40pm',
          ),
          NotificationTile(
            title: 'New Places find',
            subtitle: 'New places added to the Destinations',
            time: 'Mon,11:50pm',
          ),
          NotificationTile(
            title: 'Welcome to TrackTempo',
            subtitle: 'Welcome to TrackTempo, Now you can explore more.',
            time: 'Tue,10:50pm',
          ),
        ],
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
    home: Notifications_Home(),
  ));
}
