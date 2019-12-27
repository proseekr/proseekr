import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/globals.dart' as globals;
import 'pdfUpload.dart';

class ImageUpload extends StatefulWidget {
  ImageUpload({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    print('cropImage called');
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        ratioX: 1.0,
        ratioY: 1.0,
        maxWidth: 512,
        maxHeight: 512,
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
        toolbarTitle: 'Crop It');

    setState(() {
      print('cropImage setState called');
      _imageFile = cropped;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
      globals.obj.setImageFile(_imageFile);
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.photo_camera,
                size: 30,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
              color: Colors.blue,
            ),
            IconButton(
              icon: Icon(
                Icons.photo_library,
                size: 30,
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
              color: Colors.pink,
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Container(
                padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.black,
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  color: Colors.black,
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Uploader(
                file: _imageFile,
              ),
            )
          ]
        ],
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
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://b4di-b4d4c.appspot.com');

  StorageUploadTask _uploadTask;

//  _startUpload() {
//    print('starteUpload called');
//    String filePath = 'images/${DateTime.now()}.png';
//
//    setState(() {
//      print('setState called');
//      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      color: Colors.blue,
      label: Text('Upload to Firebase'),
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
//              _startUpload();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FilePickerDemo()),
        );
      },
    );
  }
}
