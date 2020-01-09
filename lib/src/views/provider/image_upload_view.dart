import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/provider/document_upload_view.dart';

class ImageUpload extends StatefulWidget {
  ImageUpload({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
      globals.provider.setImageFile(_imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        backgroundColor: Colors.black,
        leading: Icon(Icons.arrow_back, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.photo_camera,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(
                Icons.photo_library,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
      body: Container(
        child: _imageFile != null
            ? Center(child: Uploader(file: _imageFile))
            : Center(
                child: Text(
                "Please capture or select an image of aadhar",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              )),
      ),
    );
  }
}

/// Widget used to handle the management of
class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.black,
      elevation: 8.0,
      child: Container(
          height: 48.0,
          width: 160.0,
          child: Row(
            children: <Widget>[
              Icon(Icons.file_upload,
                  semanticLabel: "Upload", color: Colors.white),
              SizedBox(width: 16.0),
              Text("Upload to ProSeekr", style: TextStyle(color: Colors.white)),
            ],
          )),
      onPressed: () {
        print("Image upload button pressed"); //TODO: Remove logs
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilePickerDemo()),
        );
      },
    );
  }
}
