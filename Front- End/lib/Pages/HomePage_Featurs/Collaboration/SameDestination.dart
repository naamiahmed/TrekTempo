// lib/Pages/HomePage_Featurs/Collaboration/SameDestination.dart

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Pages/HomePage_Featurs/Collaboration/Chat.dart';

class SameDestination extends StatefulWidget {
  final String startPoint;
  final String endPoint;
  final String userId;

  const SameDestination({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    required this.userId,
  }) : super(key: key);

  @override
  _SameDestinationState createState() => _SameDestinationState();
}

class _SameDestinationState extends State<SameDestination> {
  List<dynamic> matchingUsers = [];
  bool isLoading = true;
  String? error;
  String status = 'searching'; // searching, waiting, confirmed
  String? partnerId;
  String? partnerName;

  @override
  void initState() {
    super.initState();
    _initializeData();
    // Start polling for status updates
    _startStatusPolling();
  }

    // Add this method inside _SameDestinationState class
  Future<void> _initializeData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:5000/api/collaboration/matching?startPoint=${Uri.encodeComponent(widget.startPoint)}&endPoint=${Uri.encodeComponent(widget.endPoint)}&userId=${widget.userId}'
        ),
      );
  
      if (response.statusCode == 200) {
        setState(() {
          matchingUsers = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load matching users';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void _startStatusPolling() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        await checkCollaborationStatus();
        _startStatusPolling();
      }
    });
  }

  Future<void> checkCollaborationStatus() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/collaboration/status/${widget.userId}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          status = data['status'];
          partnerId = data['partnerId'];
          partnerName = data['partnerName'];
        });

        if (status == 'confirmed') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                userName: partnerName ?? 'Travel Partner',
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error checking status: $e');
    }
  }

  Future<void> acceptPartner(String partnerId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/collaboration/accept'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': widget.userId,
          'partnerId': partnerId,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          status = 'waiting';
        });
      }
    } catch (e) {
      print('Error accepting partner: $e');
    }
  }

    // Update the Scaffold in SameDestination.dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Travel Partner'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _initializeData(); // Refresh the data
            },
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Finding matching travelers...'),
          ],
        ),
      );
    }

    if (status == 'waiting') {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Waiting for partner confirmation...'),
          ],
        ),
      );
    }

    if (matchingUsers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 48),
            SizedBox(height: 16),
            Text(
              'No Travelers Now, Please Wait',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: matchingUsers.length,
      itemBuilder: (context, index) {
        final user = matchingUsers[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: user['profilePicURL'] != null
                  ? NetworkImage(user['profilePicURL'])
                  : const NetworkImage(
                      'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png'),
            ),
            title: Text(
              user['name'] ?? 'Unknown User',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['bio'] ?? 'No bio available'),
                Text('Email: ${user['email'] ?? 'No email available'}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () => acceptPartner(user['_id']),
              child: const Text('Accept'),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}