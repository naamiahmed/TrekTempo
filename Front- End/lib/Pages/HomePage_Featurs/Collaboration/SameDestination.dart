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
  bool isPolling = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _startStatusPolling();
  }

  Future<void> _initializeData() async {
    if (!mounted) return;
    
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:5000/api/collaboration/matching?startPoint=${Uri.encodeComponent(widget.startPoint)}&endPoint=${Uri.encodeComponent(widget.endPoint)}&userId=${widget.userId}'
        ),
      );
  
      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          matchingUsers = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load matching users: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void _startStatusPolling() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted || !isPolling) return;
      
      await checkCollaborationStatus();
      if (status != 'confirmed' && isPolling) {
        _startStatusPolling();
      }
    });
  }

  Future<void> checkCollaborationStatus() async {
    if (!mounted) return;
  
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/collaboration/status/${widget.userId}'),
      );
  
      if (!mounted) return;
  
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        
        // Validate the data before updating state
        if (data.containsKey('status')) {
          setState(() {
            status = data['status'] ?? 'searching';
            partnerId = data['partnerId'];
            partnerName = data['partnerName'];
          });
  
          // Only navigate if we have all required data
          if (status == 'confirmed' && 
              partnerId != null && 
              partnerName != null && 
              mounted) {
            isPolling = false;
            
            await Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userName: partnerName!,
                  userId: widget.userId,
                  partnerId: partnerId!,
                ),
              ),
            );
          }
        } else {
          debugPrint('Invalid response data structure');
        }
      } else {
        debugPrint('Error response: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error checking status: $e');
    }
  }

  Future<void> acceptPartner(String partnerId) async {
    if (!mounted) return;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/collaboration/accept'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': widget.userId,
          'partnerId': partnerId,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        setState(() {
          status = 'waiting';
          this.partnerId = partnerId;
        });
      } else {
        setState(() {
          error = 'Failed to accept partner: ${response.statusCode}';
        });
      }
    } catch (e) {
      debugPrint('Error accepting partner: $e');
      setState(() {
        error = 'Error accepting partner: $e';
      });
    }
  }

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
                error = null;
              });
              _initializeData();
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

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  error = null;
                  isLoading = true;
                });
                _initializeData();
              },
              child: const Text('Retry'),
            ),
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
    isPolling = false;
    super.dispose();
  }
}