import 'package:http/http.dart' as http;
import 'dart:convert';

const endPoint = 'https://ghibliapi.vercel.app/films/';

// Given a film ID, fetch the JSON data, decode it,
// and return the dynamic object representing that film
Future<dynamic> getFilmByID(String id) async {
  // Error handling of general errors
  try {
    // Parse the endpoint string into a URI
    var uri = Uri.parse('$endPoint$id');

    // Fetch the endpoint json data
    var response = await http.get(uri);

    // Error handling of status code errors
    if (response.statusCode != 200) {
      throw Exception('Something went wrong: ${response.statusCode} received');
    }

    // Decode the json data
    var jsonData = jsonDecode(response.body);

    // return the dynamic object
    return jsonData;
  } catch (e) {
    throw Exception('Something went wrong: $e');
  }
}
