import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future getUsers() async {
    var url = Uri.parse('$baseUrl/users');
    return await http.get(url);
  }
}