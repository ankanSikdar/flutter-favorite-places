import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:places_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place-screen';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleInputController = TextEditingController();
  File _pickedImage;
  PlaceLocation _placeLocation;

  void _getLocationInfo({double lat, double long, String address}) {
    _placeLocation =
        PlaceLocation(latitude: lat, longitude: long, address: address);
  }

  void _getPickedImage(File image) {
    _pickedImage = image;
  }

  void onAdd() {
    if (_pickedImage == null ||
        _titleInputController.text.isEmpty ||
        _placeLocation == null) {
      return;
    }
    Provider.of<Places>(context, listen: false).addPlace(
      _titleInputController.text,
      _pickedImage,
      _placeLocation,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add A Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleInputController,
                    maxLength: 25,
                  ),
                  ImageInput(
                    getImageFunction: _getPickedImage,
                  ),
                  SizedBox(height: 20),
                  LocationInput(
                    saveLocation: _getLocationInfo,
                  ),
                ],
              ),
            ),
          ),
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add This Place'),
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(vertical: 20),
            onPressed: onAdd,
          )
        ],
      ),
    );
  }
}
