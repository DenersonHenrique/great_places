import 'dart:convert';
import 'app_key_util.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double? latitude,
    required double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${AppKey.MAP_API_KEY}';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${AppKey.MAP_API_KEY}';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
