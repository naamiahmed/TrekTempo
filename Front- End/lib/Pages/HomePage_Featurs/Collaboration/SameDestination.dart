import 'package:flutter/material.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Collaboration/Map.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Collaboration/chat.dart';

class SameDestination extends StatelessWidget {
  final String startPoint;
  final String endPoint;

  const SameDestination(
      {super.key, required this.startPoint, required this.endPoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Same Destination')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(context, 'User 1', 'John Doe', 25, 'Engineer', true),
            _buildCard(context, 'User 2', 'Jane Smith', 30, 'Doctor', false),
            _buildCard(
                context, 'User 3', 'Alice Johnson', 28, 'Designer', false),
            _buildCard(context, 'User 4', 'Bob Brown', 35, 'Architect', true),
            _buildCard(context, 'User 5', 'Charlie Davis', 22, 'Student', true),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String userName, String realName,
      int age, String profession, bool isMale) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('User Bio'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(isMale ? Icons.male : Icons.female),
                        const SizedBox(width: 8),
                        Text(realName),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Age: $age'),
                    Text('Profession: $profession'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(userName: userName),
                        ),
                      );
                    },
                    child: const Text('Accept'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle reject action
                      Navigator.of(context).pop();
                    },
                    child: const Text('Reject'),
                  ),
                ],
              );
            },
          );
        },
        child: ListTile(
          title: Text(userName),
          subtitle: Text('Start Point: $startPoint\nEnd Point: $endPoint'),
        ),
      ),
    );
  }
}