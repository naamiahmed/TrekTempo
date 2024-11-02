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
        Uri.parse('http://localhost:5000/api/notifications'), // Update this line with your local IP
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> notificationData = responseData['notifications'] ?? [];
        
        setState(() {
          notifications = notificationData.map((notification) => {
            'id': notification['_id'],
            'message': notification['message'] ?? 'New Notification',
            'type': notification['type'] ?? 'info',
            'createdAt': DateTime.parse(notification['createdAt']).toLocal().toString(),
            'isRead': notification['isRead'] ?? false,
            'accommodationDetails': notification['accommodationId'] ?? {},
          }).toList();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/notifications/$notificationId/read'), // Update this line with your local IP
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await fetchNotifications();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error marking notification as read: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: fetchNotifications,
        child: _isLoading && notifications.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : notifications.isEmpty
                ? const Center(child: Text('No notifications'))
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Icon(
                            notification['isRead'] 
                                ? Icons.notifications_none 
                                : Icons.notifications_active,
                            color: notification['isRead'] 
                                ? Colors.grey 
                                : Colors.blue,
                          ),
                          title: Text(notification['message']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['createdAt'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              if (notification['accommodationDetails'] != null)
                                Text(
                                  'Accommodation: ${notification['accommodationDetails']['name'] ?? 'N/A'}',
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                          onTap: () => markAsRead(notification['id']),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}