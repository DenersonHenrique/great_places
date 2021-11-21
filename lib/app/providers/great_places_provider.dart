import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:great_places/app/models/place_model.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<PlaceModel> _items = [];

  List<PlaceModel> get items => [...items];

  int get itemsCount => _items.length;

  PlaceModel getItem(int index) => _items[index];

  void addPlace(String title, File image) {
    final newPlace = PlaceModel(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
