import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

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
              onPressed: () {},
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
              onPressed: () {},
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
