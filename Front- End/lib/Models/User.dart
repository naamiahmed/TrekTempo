class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? address;
  final String? profilePicURL;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.address,
    this.profilePicURL,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'], 
      profilePicURL: json['profilePicURL'],
      bio: json['bio'],
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password, // Again, usually you avoid sending passwords in JSON
      'address': address,
      'profilePicURL': profilePicURL,
      'bio': bio,
    };
  }
}
