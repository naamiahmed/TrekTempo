import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Destinations/district_places.dart';
import 'district_conts.dart';
 
class DestinationsPage extends StatelessWidget {
   const DestinationsPage({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Districts'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: districts.length,
        itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DestinationCard(district: districts[index]), // Pass the district name here
                  ),
                );
              },

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [

                //Background Image
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(districts_images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Transparent black overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2), // Transparent light black color
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                //Centered Text
                Positioned.fill(
                  child: Center(
                    child: Text(districts[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    ),                   
                  )
                ) 
              ],
            ),
          )
        );
      },
    ),
    );
  }
}
