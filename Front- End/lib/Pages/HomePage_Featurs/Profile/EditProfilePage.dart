import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_app/Models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/Pages/HomePage_Featurs/Profile/ProfilePage.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? userId;
  Future<User>? futureProfile;
  String? profileImagePath;
  bool _isEditingBio = false;
  TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserId();
    loadUserBio();
  }

  @override
void dispose() {
  _bioController.dispose();
  super.dispose();
} 

  Future<void> loadUserBio() async {
  final profile = await futureProfile;
  if (profile != null) {
    setState(() {
      _bioController.text = profile.bio ?? '';
    });
  }
}

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
    print('Loading userId from SharedPreferences:::::: ${userId ?? "null"}');

    if (userId != null) {
      futureProfile = fetchProfileData(userId ?? "6700ae680edbeca3aef3e1e5");
    } else {
      print('No userId found in SharedPreferences');
    }
  }

  Future<User> fetchProfileData(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5000/api/auth/getProfile/$userId'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);

        if (jsonData['success'] == true && jsonData['user'] != null) {
          print('Successfully fetched user profile');

          return User.fromJson(jsonData['user']);
        } else {
          throw Exception('Failed to load user profile');
        }
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

 Future<void> _pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);
  if (image != null) {
    setState(() {
      profileImagePath = image.path; // Update the profile image path
    });

    // Upload the image to the server
    await _uploadProfilePicture(image);
  }
}

Future<void> _uploadProfilePicture(XFile image) async {
  try {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5000/api/auth/updateProfilePicture/$userId'),
    );

    request.files.add(await http.MultipartFile.fromPath('profilePic', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);

      if (jsonResponse['success'] == true) {
        // Refresh profile data
        setState(() {
          futureProfile = fetchProfileData(userId!);
        });
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        throw Exception('Failed to update profile picture');
      }
    } else {
      throw Exception('Failed to update profile picture');
    }
  } catch (e) {
    print('Error uploading profile picture: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile picture: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}

Future<void> updateBio(String newBio) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/auth/updateBio/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'bio': newBio}),
      );

      if (response.statusCode == 200) {
        setState(() {
          futureProfile = fetchProfileData(userId!);
        });
      } else {
        throw Exception('Failed to update bio');
      }
    } catch (e) {
      print('Error updating bio: $e');
    }
  }

  Future<void> _changePassword(String currentPassword, String newPassword) async {
  try {
    final response = await http.put(
      Uri.parse('http://localhost:5000/api/auth/changePassword/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      final error = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error['message'] ?? 'Failed to change password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ),
    );
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
              const Text(
                'Change Profile Picture',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Upload from Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ProfilePage(), 
              ),
            );
          },
        ),
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.white,
         bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<User>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              User user = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 50),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: (user.profilePicURL != null &&
                                user.profilePicURL!.isNotEmpty)
                            ? NetworkImage(user.profilePicURL!)
                            : const NetworkImage(
                                'https://sricarschennai.in/wp-content/uploads/2022/11/avatar.png'),
                      ),
                      const SizedBox(
                          width: 8), // Space between profile picture and icon
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed:
                            _showImageSourceOptions, // Show options for changing profile picture
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.email,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              const SizedBox(height: 16),
              _buildBioSection(),

                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      _showChangePasswordDialog(context);
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
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
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

void _showChangePasswordDialog(BuildContext context) {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Change Password'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: currentPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value != newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );
              }
            },
            child: const Text('Change Password'),
          ),
        ],
      );
    },
  );
}

Widget _buildBioSection() {
  return FutureBuilder<User>(
    future: futureProfile,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      
      if (snapshot.hasData) {
        // Initialize the controller with existing bio if not already set
        if (_bioController.text.isEmpty) {
          _bioController.text = snapshot.data?.bio ?? '';
        }
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isEditingBio ? Icons.check : Icons.edit),
                    onPressed: () async {
                      if (_isEditingBio) {
                        await updateBio(_bioController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bio updated successfully'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      setState(() {
                        _isEditingBio = !_isEditingBio;
                      });
                    },
                  ),
                ],
              ),
              _isEditingBio
                  ? TextField(
                      controller: _bioController,
                      decoration: const InputDecoration(
                        hintText: 'Write something about yourself...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    )
                  : Text(
                      _bioController.text.isEmpty
                          ? 'No bio added yet'
                          : _bioController.text,
                      style: const TextStyle(fontSize: 16),
                    ),
            ],
          ),
        );
      }
      
      return const Text('Failed to load bio');
    }
  );
}
  }


