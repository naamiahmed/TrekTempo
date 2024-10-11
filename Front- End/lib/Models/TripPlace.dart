class TripPlace {
  final String district;
  final String name;
  final String location;
  final String description;
  final List<String> images;
  final String budget;
  final String tripPersonType;
  final String tripType;
  final String locationLink;

  TripPlace({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.budget,
    required this.tripPersonType,
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
      budget: json['budget'],
      tripPersonType: json['tripPersonType'],
      tripType: json['tripType'],
      locationLink: json['locationLink'],

    );
  }
}