import 'package:flutter/material.dart';
import 'package:places_app/screens/places_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amber,
          iconTheme: IconThemeData(
            color: Colors.white,
          )),
      title: 'Places App',
      home: PlacesListScreen(),
    );
  }
}
