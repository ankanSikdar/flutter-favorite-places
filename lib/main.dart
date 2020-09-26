import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places_app/providers/places.dart';
import 'package:places_app/screens/add_place_screen.dart';
import 'package:places_app/screens/maps_screen.dart';
import 'package:places_app/screens/place_details_screen.dart';
import 'package:places_app/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Places>(
      create: (context) => Places(),
      builder: (context, child) {
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
            PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen(),
            AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
            MapsScreen.routeName: (context) => MapsScreen(),
          },
        );
      },
    );
  }
}
