class Place {
  final String district;
  final String name;
  final String location;
  final String description;
  final int likes;
  final List<String> images;
  final String budget;
  final String tripPersonType;
  final String tripType;
  final String weather;
  final String locationLink;

  Place({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.likes,
    required this.images,
    required this.budget,
    required this.tripPersonType,
    required this.tripType,
    required this.weather,
    required this.locationLink,
  });
    factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      likes: json['likes'],
      images: List<String>.from(json['images']),
      budget: json['budget'],
      tripPersonType: json['tripPersonType'],
      tripType: json['tripType'],
      weather: json['weather'],
      locationLink: json['locationLink'],
    );
  }
}