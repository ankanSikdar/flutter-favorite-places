import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';

class Places extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    _items.add(Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: pickedImage,
      location: null,
    ));
  }
}
