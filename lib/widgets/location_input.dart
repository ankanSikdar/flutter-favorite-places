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
  String _address;
  bool _isLoading = false;

  Future<void> _setImageAndAddress() async {
    final url = LocationHelper.generateLocationPreviewImage(
        latitude: _selectedLatLng.latitude,
        longitude: _selectedLatLng.longitude);

    final locationAddress = await LocationHelper.getPlaceAddress(
      latitude: _selectedLatLng.latitude,
      longitude: _selectedLatLng.longitude,
    );

    setState(() {
      _previewImageUrl = url;
      _address = locationAddress;
      _isLoading = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });
    final locationApi = Location.instance;
    locationApi.changeSettings(accuracy: LocationAccuracy.high);
    final location = await locationApi.getLocation();
    _selectedLatLng = LatLng(location.latitude, location.longitude);
    _setImageAndAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 220,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey,
          )),
          child: _isLoading
              ? Text('Loading Satellite Data...')
              : _previewImageUrl == null
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
              onPressed: _isLoading ? null : _getCurrentLocation,
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
              onPressed: _isLoading
                  ? null
                  : () async {
                      final response = await Navigator.pushNamed(
                          context, MapsScreen.routeName);
                      if (response != null) {
                        _selectedLatLng = response;
                        _setImageAndAddress();
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
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _isLoading
              ? Text('Loading Address...')
              : Text(
                  _address == null
                      ? 'Address: No Place Selected!'
                      : 'Address: $_address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}
