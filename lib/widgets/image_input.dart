import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 150,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          child: _storedImage == null
              ? Text(
                  'No Image Chosen',
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.fitWidth,
                ),
        ),
        RaisedButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.camera_enhance,
            color: Theme.of(context).iconTheme.color,
          ),
          label: Text(
            'Add a picture',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
