class TripPlace {
  final String district;
  final String name;
  final String location;
  final String description;
  final List<String> images;
  final String tripType;
  final String locationLink;

  TripPlace({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.tripType,
    required this.locationLink,
  });
    factory TripPlace.fromJson(Map<String, dynamic> json) {
    return TripPlace(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      images: List<String>.from(json['images']),
      tripType: json['tripType'],
      locationLink: json['locationLink'],

    );
  }
}