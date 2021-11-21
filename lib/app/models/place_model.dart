import 'dart:io';

class PlaceLocationModel {
  final int latitude;
  final int longitude;
  final String? address;

  PlaceLocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocationModel? location;
  final File image;

  PlaceModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
  });
}
