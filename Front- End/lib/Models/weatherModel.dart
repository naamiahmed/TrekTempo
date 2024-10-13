class ApiResponse {
  final String location;
  final double temperature;
  final String condition;
  final double windSpeed;
  final int humidity;
  final String icon;

  ApiResponse({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.windSpeed,
    required this.humidity,
    required this.icon, 
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      location: json['location']['name'], 
      temperature: json['current']['temp_c'].toDouble(), 
      condition: json['current']['condition']['text'],
      windSpeed: json['current']['wind_kph'].toDouble(), 
      humidity: json['current']['humidity'], 
      icon: 'https:${json['current']['condition']['icon']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'current': {
        'temp_c': temperature,
        'condition': {
          'text': condition,
          'icon': icon,
        },
        'wind_kph': windSpeed,
        'humidity': humidity,
      },
    };
  }
}
