import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Booking/EditRooms.dart';

class RoomsView extends StatefulWidget {
  @override
  _RoomsViewState createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  List<Room> rooms = [
    Room(number: 1, isAvailable: false),
    Room(number: 2, isAvailable: false),
    Room(number: 3, isAvailable: true),
    Room(number: 4, isAvailable: false),
    Room(number: 5, isAvailable: false),
    Room(number: 6, isAvailable: true),
    Room(number: 7, isAvailable: true),
    Room(number: 8, isAvailable: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return RoomCard(room: rooms[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () async {
                final updatedRooms = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditRooms(rooms: rooms),
                  ),
                );
                if (updatedRooms != null) {
                  setState(() {
                    rooms = updatedRooms;
                  });
                }
              },
              child: Text('Edit Rooms'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoomCard {
}