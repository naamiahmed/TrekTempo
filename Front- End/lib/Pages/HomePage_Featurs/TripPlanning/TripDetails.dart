import 'package:flutter/material.dart';

class TripPlanDetails extends StatelessWidget {
  final Map<String, dynamic> tripPlan;
  final String tripId;

  const TripPlanDetails({Key? key, required this.tripPlan, required this.tripId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Plan Details'),
        backgroundColor: Colors.blueAccent, // Match theme color here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Plan Name
            Text(
              tripPlan['tripName'] ?? 'Trip Plan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // Match theme color
              ),
            ),
            SizedBox(height: 16),
            
            // Starting Point and Ending Point
            _buildDetailRow('Starting Point', tripPlan['startingPoint']),
            _buildDetailRow('Ending Point', tripPlan['endingPoint']),
            SizedBox(height: 10),
            
            // Duration
            _buildDetailRow('Duration', '${tripPlan['duration']} days'),
            SizedBox(height: 10),
            
            // Budget
            _buildDetailRow('Budget', tripPlan['budget']),
            SizedBox(height: 10),
            
            // Trip Person Type
            _buildDetailRow('Trip Person Type', tripPlan['tripPersonType']),
            SizedBox(height: 10),
            
            // Trip Type
            _buildDetailRow('Trip Type', tripPlan['tripType']),
            SizedBox(height: 10),
            
            // Interested Places
            if (tripPlan['interested'] != null && tripPlan['interested'].isNotEmpty)
              _buildDetailRow('Places of Interest', tripPlan['interested'].join(', ')),
            
            // Add more fields if needed
          ],
        ),
      ),
    );
  }

  // Helper widget to display detail rows
  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87, // Match theme color
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}