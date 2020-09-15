import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  PickedFile _storedImage;

  Future<void> _pickImage() async {
    _storedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {});
  }

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
              : Image(
                  image: FileImage(File(_storedImage.path)),
                  fit: BoxFit.fitWidth,
                ),
        ),
        RaisedButton.icon(
          onPressed: _pickImage,
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
