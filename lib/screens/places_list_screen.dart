import 'package:flutter/material.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<Places>(
        builder: (context, places, child) {
          if (places.items.length == 0) {
            return Center(
              child: Text('No Places Added Yet!'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(places.items[index].image),
                ),
                title: Text(places.items[index].title),
              );
            },
            itemCount: places.items.length,
          );
        },
      ),
    );
  }
}
