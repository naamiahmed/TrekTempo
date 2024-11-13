class Accommodation {
  final String district;
  final String name;
  final String location;
  final String description;
  final List<String> images;
  final String budget;
  final String locationLink;
  final int dayCost;
  final String contact;
  

  Accommodation({
    required this.district,
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.budget,
    required this.locationLink,
    required this.dayCost,
    required this.contact,
  });

  factory Accommodation.fromJson(Map<String, dynamic> json) {
    return Accommodation(
      district: json['district'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      images: List<String>.from(json['images']),
      budget: json['budget'],
      locationLink: json['locationLink'],
      contact: json['contact'],
      dayCost: json['dayCost'] is String ? int.tryParse(json['dayCost']) ?? 0 : json['dayCost'],
    );
  }
}