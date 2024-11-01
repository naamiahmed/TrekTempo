import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Notifications_Home extends StatefulWidget {
  final String userId;

  const Notifications_Home({super.key, required this.userId});

  @override
  _Notifications_HomeState createState() => _Notifications_HomeState();
}

class _Notifications_HomeState extends State<Notifications_Home> {
  List<Map<String, dynamic>> notifications = [];
  Timer? _refreshTimer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    _startPeriodicRefresh();
  }

  void _startPeriodicRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      fetchNotifications();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchNotifications() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);
    
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/notifications/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> notificationData = jsonDecode(response.body);
        setState(() {
          notifications = notificationData.map((notification) => {
            'id': notification['_id'],
            'title': notification['title'],
            'subtitle': notification['subtitle'],
            'time': notification['time'],
            'isRead': notification['isRead'] ?? false,
          }).toList();
        });
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'))
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      final response = await http.delete(
        Uri.parse('http://yourserver.com/api/notifications/${widget.userId}/clear-all'),
      );

      if (response.statusCode == 200) {
        setState(() => notifications.clear());
      } else {
        throw Exception('Failed to clear notifications');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          if (notifications.isNotEmpty)
            TextButton(
              onPressed: clearAllNotifications,
              child: const Text('Clear all', style: TextStyle(color: Colors.blue)),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 0.5,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchNotifications,
        child: _isLoading && notifications.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : notifications.isEmpty
                ? const Center(child: Text('No notifications'))
                : ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationTile(
                        title: notification['title'],
                        subtitle: notification['subtitle'],
                        time: notification['time'],
                        isRead: notification['isRead'],
                        onTap: () async {
                          // Handle notification tap - mark as read
                          // Add your logic here
                        },
                      );
                    },
                  ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isRead ? Colors.white : Colors.blue[50],
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.notifications,
                color: isRead ? Colors.grey : Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}