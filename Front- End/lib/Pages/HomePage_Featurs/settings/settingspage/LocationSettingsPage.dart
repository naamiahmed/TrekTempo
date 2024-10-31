import 'package:flutter/material.dart';

class LocationSettingsPage extends StatelessWidget {
  const LocationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Settings'),
      ),
      body: const Center(
        child: Text('Location settings options go here.'),
      ),
    );
  }
}
