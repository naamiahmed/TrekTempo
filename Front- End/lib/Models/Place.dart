class Place {
  final String district;
  final String city;
  final String name;
  final String location;
  final String direction;
  final String description;
  final int likes;
  final List<String> images;

  Place({
    required this.district,
    required this.city,
    required this.name,
    required this.location,
    required this.direction,
    required this.description,
    required this.likes,
    required this.images,
  });
    factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      district: json['district'],
      city: json['city'],
      name: json['name'],
      location: json['location'],
      direction: json['direction'],
      description: json['description'],
      likes: json['likes'],
      images: List<String>.from(json['images']),
    );
  }
}