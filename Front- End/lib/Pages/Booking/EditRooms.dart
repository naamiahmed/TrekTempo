import 'package:flutter/material.dart';

class EditRooms extends StatefulWidget {
  final List<Room> rooms;

  EditRooms({required this.rooms});

  @override
  _EditRoomsState createState() => _EditRoomsState();
}

class _EditRoomsState extends State<EditRooms> {
  late List<Room> editedRooms;

  @override
  void initState() {
    super.initState();
    editedRooms = List.from(widget.rooms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Rooms'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save changes and return
              Navigator.pop(context, editedRooms);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: editedRooms.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.hotel),
              title: Text('Room ${editedRooms[index].number}'),
              trailing: Switch(
                value: editedRooms[index].isAvailable,
                onChanged: (value) {
                  setState(() {
                    editedRooms[index] = Room(
                      number: editedRooms[index].number,
                      isAvailable: value,
                    );
                  });
                },
              ),
              subtitle: Text(
                editedRooms[index].isAvailable ? 'Available' : 'Booked',
              ),
            ),
          );
        },
      ),
    );
  }
}

class Room {
  final int number;
  final bool isAvailable;

  Room({required this.number, required this.isAvailable});
}