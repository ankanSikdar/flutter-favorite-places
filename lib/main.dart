import 'package:flutter/material.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      title: 'Places App',
      home: PlacesListScreen(),
      routes: {
        PlacesListScreen.routeName: (context) => PlacesListScreen(),
        AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
      },
    );
  }
}
