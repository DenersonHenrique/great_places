import 'app_key_util.dart';

class LocationUtil {
  static String generateLocationPreviewImage({
    required double? latitude,
    required double? longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=15&size=600x400&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=${AppKey.MAP_API_KEY}';
  }
}
