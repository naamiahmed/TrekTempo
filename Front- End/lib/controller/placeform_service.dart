import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class PlaceService {
  Future<http.StreamedResponse> createNewPlace({
    required String placeName,
    required String district,
    required String city,
    required String location,
    required String direction,
    required String description,
    required List<File> images,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://trektempo.onrender.com/api/createNewPlace'),
    );

    // Add form fields
    request.fields.addAll({
      'name': placeName,
      'district': district,
      'city': city,
      'location': location,
      'direction': direction,
      'description': description,
    });

    // Attach images to the request
    for (File image in images) {
      String fileName = basename(image.path);
      request.files.add(
        await http.MultipartFile.fromPath('images', image.path, filename: fileName),
      );
    }

    try {
      // Send the request
      var response = await request.send();
      return response;
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}