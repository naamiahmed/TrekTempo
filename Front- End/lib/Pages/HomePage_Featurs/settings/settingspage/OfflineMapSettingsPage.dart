import 'package:flutter/material.dart';

class OfflineMapSettingsPage extends StatefulWidget {
  @override
  _OfflineMapSettingsPageState createState() => _OfflineMapSettingsPageState();
}

class _OfflineMapSettingsPageState extends State<OfflineMapSettingsPage> {
  bool _isDownloading = false; // To track download progress
  double _downloadProgress = 0.0; // Track the percentage of the download

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offline Maps'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section for downloading a new offline map
            Text(
              'Download Offline Maps',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Download map areas to use when traveling in locations without an internet connection.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isDownloading
                  ? null
                  : () {
                      _startMapDownload();
                    },
              child: _isDownloading ? Text('Downloading...') : Text('Download Map Area'),
            ),
            SizedBox(height: 10),
            if (_isDownloading)
              LinearProgressIndicator(
                value: _downloadProgress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            SizedBox(height: 30),

            // Section for managing downloaded offline maps
            Text(
              'Manage Offline Maps',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map of Sri Lanka'),
              subtitle: Text('Downloaded - 150 MB'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteOfflineMap();
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Colombo City Map'),
              subtitle: Text('Downloaded - 50 MB'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteOfflineMap();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startMapDownload() {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    // Simulate map download progress (this would be actual downloading logic in a real app)
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _downloadProgress = 0.25;
      });
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _downloadProgress = 0.5;
      });
    });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _downloadProgress = 0.75;
      });
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _downloadProgress = 1.0;
        _isDownloading = false;
      });

      // Show a message that the map has been downloaded
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Map area downloaded successfully!')),
      );
    });
  }

  void _deleteOfflineMap() {
    // Logic to delete the offline map
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Offline map deleted!')),
    );
  }
}
