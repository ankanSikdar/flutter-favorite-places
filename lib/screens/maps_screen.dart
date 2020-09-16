import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:places_app/keys.dart';

class MapsScreen extends StatefulWidget {
  static const routeName = '/maps-screen';

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  MapboxMapController mapController;
  LatLng latLng;

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _onLongPress(double latitude, double longitude) {
    mapController.clearCircles();
    mapController.addCircle(CircleOptions(
      geometry: LatLng(latitude, longitude),
      circleRadius: 10,
      circleColor: 'red',
    ));
    setState(() {
      latLng = LatLng(latitude, longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Location'),
      ),
      body: MapboxMap(
        accessToken: API_KEY,
        styleString: MapboxStyles.SATELLITE_STREETS,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            22.694825699179827,
            88.44378066601621,
          ),
          zoom: 16,
        ),
        onMapCreated: _onMapCreated,
        compassEnabled: true,
        myLocationEnabled: true,
        myLocationRenderMode: MyLocationRenderMode.GPS,
        onMapLongClick: (point, coordinates) {
          _onLongPress(coordinates.latitude, coordinates.longitude);
        },
      ),
      floatingActionButton: latLng == null
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.check,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                Navigator.of(context).pop(latLng);
              },
            ),
    );
  }
}
