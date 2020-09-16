import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app/helpers/db_helpers.dart';
import 'package:places_app/models/place.dart';

class Places extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    Place newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: pickedImage,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      tableName: 'user_places',
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelper.fetch(tableName: 'user_places');
    _items = data
        .map((element) => Place(
              id: element['id'],
              title: element['title'],
              image: File(element['image']),
              location: null,
            ))
        .toList();
    notifyListeners();
  }
}
