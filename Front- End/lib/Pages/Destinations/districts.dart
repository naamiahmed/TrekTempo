import 'package:flutter/material.dart';
import 'package:travel_app/Pages/Destinations/district_places.dart';
import 'package:travel_app/Pages/HomePage_Featurs/MainHomePage.dart';
import 'district_conts.dart';

class DestinationsPage extends StatelessWidget {
  const DestinationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MainHomePage();
            }));
          },
        ),
        title: const Text('Districts',
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 0.5,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: districts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DestinationCard(district: districts[index]),
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
                          color: Colors.black.withOpacity(
                              0.2), // Transparent light black color
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    //Centered Text
                    Positioned.fill(
                        child: Center(
                      child: Text(
                        districts[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
                  ],
                ),
              ));
        },
      ),
    );
  }
}
