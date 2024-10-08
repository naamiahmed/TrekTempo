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
                if (weatherData.current?.condition?.icon != null)
                  Image.network(
                    'https:${weatherData.current?.condition?.icon}',
                    width: 50,
                    height: 50,
                  ),
                const SizedBox(width: 8),
                // Text(
                //   weatherData.location?.name ?? 'Unknown Location',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(height: 4),
                Text(
                  weatherData.current?.condition?.text ?? 'No condition',
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
                  '${weatherData.current?.tempC?.toString()}°C',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Wind: ${weatherData.current?.windKph?.toString() ?? '0'} kph',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Humidity: ${weatherData.current?.humidity?.toString() ?? '0'}%',
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
