import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Edit',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String username = 'Rifthan Fathir'; // Variable to store the username
  final TextEditingController usernameController = TextEditingController(); // Controller for the username input
  bool isEditingUsername = false; // Flag for editing mode
  String? profileImagePath; // Variable to store the path of the profile image

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image from the specified source
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        profileImagePath = image.path; // Update the profile image path
      });
    }
  }

  // Show the bottom sheet with options to change the profile picture
  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take a Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Upload from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profileImagePath != null
                      ? AssetImage(profileImagePath!) // Use selected image
                      : AssetImage('assets/images/naami.jpg'), // Default image
                ),
                SizedBox(width: 8), // Space between profile picture and icon
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: _showImageSourceOptions, // Show options for changing profile picture
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Show a TextField when editing, otherwise show the username
                isEditingUsername
                    ? Expanded(
                        child: TextField(
                          controller: usernameController..text = username,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Text(
                        username,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                // Only show the edit icon if not in editing mode
                if (!isEditingUsername)
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      setState(() {
                        isEditingUsername = true; // Enter editing mode
                        usernameController.text = username; // Set current username in controller
                      });
                    },
                  ),
                // Show the Save button when editing
                if (isEditingUsername)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        username = usernameController.text; // Update username
                        isEditingUsername = false; // Exit editing mode
                      });
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                _showChangePasswordDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Implement your password change logic here
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
