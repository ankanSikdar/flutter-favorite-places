import 'package:flutter/material.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/widgets/places_item.dart';
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
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<Places>(
            builder: (_, places, child) {
              if (places.items.length == 0) {
                return Center(
                  child: Text('No Places Added Yet!'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return PlacesItem(
                    id: places.items[index].id,
                    image: places.items[index].image,
                    title: places.items[index].title,
                    address: places.items[index].location.address,
                  );
                },
                itemCount: places.items.length,
              );
            },
          );
        },
      ),
    );
  }
}
