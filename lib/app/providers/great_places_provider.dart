import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:great_places/app/models/place_model.dart';
import 'package:great_places/app/utils/database_util.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<PlaceModel> _items = [];

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
    DataBaseUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
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
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}
