import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Handle more actions
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for chats & messages',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                MessageTile(
                  name: 'Raashid',
                  message: 'Hi, Naami! 👋 How are you doing?',
                  time: '09:46',
                  imagePath: 'assets/images/Raashid.jpg', // Replace with your image path
                ),
                MessageTile(
                  name: 'Sandhushi',
                  message: 'Typing...',
                  time: '08:42',
                  imagePath: 'assets/images/Sandushi.enc', // Replace with your image path
                ),
                MessageTile(
                  name: 'Fathir',
                  message: 'You: Cool! 😎 Let\'s meet at 18:00 near the traveling!',
                  time: 'Yesterday',
                  imagePath: 'assets/images/fathir.enc', // Replace with your image path
                ),
                MessageTile(
                  name: 'Raashidha',
                  message: 'Thank you for coming! Your or...',
                  time: '05:52',
                  imagePath: 'assets/images/profile4.png', // Replace with your image path
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Destinations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imagePath;

  const MessageTile({
    required this.name,
    required this.message,
    required this.time,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Text(time),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MessagesPage(),
  ));
}
