class Accommodation {
  final String district;
  final String name;
  final String location;
  final String description;
  final List<String> images;

  Accommodation({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.images
  });
    factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      images: List<String>.from(json['images'])
    );
  }
}