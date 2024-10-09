class Place {
  final String district;
  final String name;
  final String location;
  final String description;
  final int likes;
  final List<String> images;

  Place({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.likes,
    required this.images
  });
    factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      likes: json['likes'],
      images: List<String>.from(json['images'])
    );
  }
}