import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app/helpers/db_helpers.dart';
import 'package:places_app/models/place.dart';

class Places extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
      String title, File pickedImage, PlaceLocation selectedLocation) {
    Place newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: pickedImage,
      location: selectedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      tableName: 'user_places',
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_long': newPlace.location.longitude,
        'address': newPlace.location.address,
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
              location: PlaceLocation(
                latitude: element['loc_lat'],
                longitude: element['loc_long'],
                address: element['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
