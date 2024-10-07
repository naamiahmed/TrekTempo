class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    current = json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location?.toJson(),
      'current': current?.toJson(),
    };
  }
}

class Location {
  String? name;

  Location({this.name});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class Current {
  num? tempC;
  num? isDay;
  Condition? condition;
  num? windKph;
  num? pressureIn;
  num? humidity;
  num? uv;

  Current({
    this.tempC,
    this.isDay,
    this.condition,
    this.windKph,
    this.pressureIn,
    this.humidity,
    this.uv,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null ? Condition.fromJson(json['condition']) : null;
    windKph = json['wind_kph'];
    pressureIn = json['pressure_in'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'is_day': isDay,
      'condition': condition?.toJson(),
      'wind_kph': windKph,
      'pressure_in': pressureIn,
      'humidity': humidity,
      'uv': uv,
    };
  }
}

class Condition {
  String? text;
  String? icon;
  num? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }
}