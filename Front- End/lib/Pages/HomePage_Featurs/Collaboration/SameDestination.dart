import 'package:flutter/material.dart';

class SameDestination extends StatelessWidget {
  final String startPoint;
  final String endPoint;

  const SameDestination(
      {Key? key, required this.startPoint, required this.endPoint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Same Destination')),
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
                title: Text('User Bio'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(isMale ? Icons.male : Icons.female),
                        SizedBox(width: 8),
                        Text(realName),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text('Age: $age'),
                    Text('Profession: $profession'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Accept'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle reject action
                      Navigator.of(context).pop();
                    },
                    child: Text('Reject'),
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
