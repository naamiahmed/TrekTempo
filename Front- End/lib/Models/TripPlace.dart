class TripPlace {
  final String district;
  final String name;
  final String location;
  final String description;
  final int weather;
  final List<String> images;

  TripPlace({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.weather,
    required this.images
  });
    factory TripPlace.fromJson(Map<String, dynamic> json) {
    return TripPlace(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      weather: json['weather'],
      images: List<String>.from(json['images'])
    );
  }
}