import 'dart:convert';
import 'package:places_app/keys.dart';
import 'package:http/http.dart' as http;

const String APIKey = API_KEY;

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,18/1280x720?access_token=$APIKey';
  }

  static Future<String> getPlaceAddress(
      {double latitude, double longitude}) async {
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$APIKey';
    final response = await http.get(url);
    List<dynamic> data = json.decode(response.body)['features'];
    return data[1]['place_name'];
  }
}
