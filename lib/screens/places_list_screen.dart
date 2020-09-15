import 'package:flutter/material.dart';
import 'package:places_app/screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  static const routeName = '/places-list-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AddPlaceScreen.routeName);
        },
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
