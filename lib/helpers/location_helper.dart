import 'package:places_app/keys.dart';

const String APIKey = API_KEY;

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B$longitude%2C$latitude%5D%7D)/$longitude,$latitude,18/1280x720?access_token=$APIKey';
  }
}
