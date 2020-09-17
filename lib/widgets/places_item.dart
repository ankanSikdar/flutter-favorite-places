import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places_app/screens/place_details_screen.dart';

class PlacesItem extends StatelessWidget {
  final String id;
  final File image;
  final String title;
  final String address;

  PlacesItem({this.id, this.image, this.title, this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PlaceDetailsScreen.routeName,
          arguments: id,
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: FileImage(image),
              fit: BoxFit.cover,
            ),
          ),
          footer: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.black54,
            ),
            child: ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  address,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
