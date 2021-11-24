import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:great_places/app/models/place_model.dart';
import 'package:great_places/app/utils/database_util.dart';
import 'package:great_places/app/utils/location_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items => [...items];

  int get itemsCount => _items.length;

  PlaceModel getItem(int index) => _items[index];

  void addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = PlaceModel(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DataBaseUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
    });

    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final list = await DataBaseUtil.getData('places');
    _items = list
        .map(
          (item) => PlaceModel(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocationModel(
              latitude: item['latitude'],
              longitude: item['longitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  void removePlace(String id) async {
    await DataBaseUtil.delete('places', id);
    notifyListeners();
  }
}
