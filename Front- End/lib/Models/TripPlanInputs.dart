
class TripPlanInputs {
  String endPoint;
  String budget;
  String tripPersonType;
  String tripType;


  // Constructor
  TripPlanInputs({
    required this.endPoint,
    required this.budget,
    required this.tripPersonType,
    required this.tripType,
  });

  // Method to convert object to JSON (for sending to backend)
  Map<String, dynamic> toJson() {
    return {
      'endPoint': endPoint,
      'budget': budget,
      'tripPersonType': tripPersonType,
      'tripType': tripType,
    };
  }
}