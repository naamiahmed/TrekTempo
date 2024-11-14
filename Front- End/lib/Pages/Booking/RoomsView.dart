import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Booking/EditRooms.dart';
import 'package:travel_app/Pages/Booking/booking_home.dart';

class RoomsView extends StatefulWidget {
  final AccommodationPlace place;
  final Function(AccommodationPlace) onDelete;

  RoomsView({
    required this.place,
    required this.onDelete,
  });

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

  Future<void> _showDeleteConfirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete ${widget.place.name}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                widget.onDelete(widget.place);
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to BookingHomePage
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
          ),
        ],
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

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hotel,
            size: 40,
            color: room.isAvailable ? Colors.green : Colors.red,
          ),
          SizedBox(height: 8),
          Text(
            'Room ${room.number}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            room.isAvailable ? 'Available' : 'Booked',
            style: TextStyle(
              color: room.isAvailable ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}