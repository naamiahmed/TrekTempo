class Place {
  final String _id;
  final String district;
  final String city;
  final String name;
  final String location;
  final String direction;
  final String description;
  final int likes;
  final List<String> images;
  final List<String> likedBy;

  Place({
    required String id,
    required this.district,
    required this.city,
    required this.name,
    required this.location,
    required this.direction,
    required this.description,
    required this.likes,
    required this.images,
    required this.likedBy,
  }) : _id = id;

  String get id => _id;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['_id'], 
      district: json['district'],
      city: json['city'],
      name: json['name'],
      location: json['location'],
      direction: json['direction'],
      description: json['description'],
      likes: json['likes'],
      images: List<String>.from(json['images']),
      likedBy: List<String>.from(json['likedBy'])
    );
  }
}
