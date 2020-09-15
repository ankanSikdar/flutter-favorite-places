import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class ImageInput extends StatefulWidget {
  final Function getImageFunction;

  ImageInput({this.getImageFunction});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _pickImage() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.gallery, // Change to Camera Later
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(image.path);
    });
    Directory appDir = await sysPaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.getImageFunction(savedImage);
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
                  image: FileImage(_storedImage),
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
