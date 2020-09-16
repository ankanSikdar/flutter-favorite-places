import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  LatLng _selectedLatLng;

  void _setImage() {
    final url = LocationHelper.generateLocationPreviewImage(
        latitude: _selectedLatLng.latitude,
        longitude: _selectedLatLng.longitude);
    setState(() {
      _previewImageUrl = url;
    });
    LocationHelper.getPlaceAddress(
      latitude: _selectedLatLng.latitude,
      longitude: _selectedLatLng.longitude,
    );
  }

  Future<void> _getCurrentLocation() async {
    final locationApi = Location.instance;
    locationApi.changeSettings(accuracy: LocationAccuracy.high);
    final location = await locationApi.getLocation();
    _selectedLatLng = LatLng(location.latitude, location.longitude);
    _setImage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
          )),
          child: _previewImageUrl == null
              ? Text('No Location Chosen')
              : Image(
                  image: NetworkImage(_previewImageUrl),
                  fit: BoxFit.fitWidth,
                ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RaisedButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).iconTheme.color,
              ),
              label: Text(
                'Current Location',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            RaisedButton.icon(
              onPressed: () async {
                final response =
                    await Navigator.pushNamed(context, MapsScreen.routeName);
                if (response != null) {
                  _selectedLatLng = response;
                  _setImage();
                }
              },
              icon: Icon(
                Icons.map,
                color: Theme.of(context).iconTheme.color,
              ),
              label: Text(
                'Choose on Map',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
