import 'package:flutter/material.dart';
import 'package:travel_app/Models/weatherModel.dart';

// Weather Card Widget
class WeatherCard extends StatelessWidget {
  final ApiResponse weatherData;

  const WeatherCard({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (weatherData.icon.isNotEmpty)
                  Image.network(
                    weatherData.icon,
                    width: 40,
                    height: 40,
                  ),
                const SizedBox(height: 8),
                Text(
                  weatherData.condition.isNotEmpty
                      ? weatherData.condition
                      : 'No condition',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${weatherData.temperature.toString()}°C',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Wind: ${weatherData.windSpeed.toString()} kph',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Humidity: ${weatherData.humidity.toString()}%',
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
