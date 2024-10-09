import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';

// Weather Card Widget
class WeatherCard extends StatelessWidget {
  final ApiResponse weatherData;

  const WeatherCard({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Weather icon and condition
            Column(
              children: [
                // Display the weather icon if available
                if (weatherData.icon.isNotEmpty)
                  Image.network(
                    weatherData.icon, // Use the icon directly from weatherData
                    width: 50,
                    height: 50,
                  ),
                   const SizedBox(width: 8),
                // Text(
                //   weatherData.location.isNotEmpty ? weatherData.location : 'No location',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(width: 8),
                // Display the weather condition text
                Text(
                  weatherData.condition.isNotEmpty ? weatherData.condition : 'No condition',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Right side: Temp, Wind, and Humidity
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${weatherData.temperature.toString()}°C', // Display temperature
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wind: ${weatherData.windSpeed.toString()} kph', // Display wind speed
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Humidity: ${weatherData.humidity.toString()}%', // Display humidity
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
