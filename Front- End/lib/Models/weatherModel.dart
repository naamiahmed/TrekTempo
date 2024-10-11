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
      location: json['location']['name'], // Get the name of the location
      temperature: json['current']['temp_c'].toDouble(), // Get temperature in Celsius
      condition: json['current']['condition']['text'], // Get weather condition text
      windSpeed: json['current']['wind_kph'].toDouble(), // Get wind speed in kph
      humidity: json['current']['humidity'], // Get humidity level
      icon: 'https:${json['current']['condition']['icon']}', // Get the icon URL
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
