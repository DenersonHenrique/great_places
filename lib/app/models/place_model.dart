import 'dart:io';

class PlaceLocationModel {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocationModel({
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
