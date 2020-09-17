import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/maps_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final place = Provider.of<Places>(context, listen: false).getPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Place Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: FileImage(place.image),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              place.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Address: ${place.location.address}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(LocationHelper.generateLocationPreviewImage(
                  latitude: place.location.latitude,
                  longitude: place.location.longitude,
                )),
                fit: BoxFit.cover,
              ),
            ),
            RaisedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, MapsScreen.routeName,
                    arguments: LatLng(
                      place.location.latitude,
                      place.location.longitude,
                    ));
              },
              icon: Icon(
                Icons.map,
                color: Theme.of(context).iconTheme.color,
              ),
              label: Text(
                'View on Map',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
