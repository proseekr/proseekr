//import 'dart:io';
//
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:image_cropper/image_cropper.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:proseekr/src/controllers/actor_selection_controller.dart';
//import 'package:proseekr/src/models/globals.dart' as globals;
//import 'package:proseekr/src/views/job_provider/userLogin.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//
//class SeekerImageUpload extends StatefulWidget {
//  SeekerImageUpload({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _SeekerImageUploadState createState() => _SeekerImageUploadState();
//}
//
//class _SeekerImageUploadState extends State<SeekerImageUpload> {
//  @override
//  File _imageFile;
//
//  /// Cropper plugin
//  Future<void> _cropImage() async {
//    print('cropImage called');
//    File cropped = await ImageCropper.cropImage(
//        sourcePath: _imageFile.path,
//        ratioX: 1.0,
//        ratioY: 1.0,
//        maxWidth: 512,
//        maxHeight: 512,
//        toolbarColor: Colors.purple,
//        toolbarWidgetColor: Colors.white,
//        toolbarTitle: 'Crop It');
//
//    setState(() {
//      print('cropImage setState called');
//      _imageFile = cropped;
//    });
//  }
//
//  /// Select an image via gallery or camera
//  Future<void> _pickImage(ImageSource source) async {
//    File selected = await ImagePicker.pickImage(source: source);
//
//    setState(() {
//      _imageFile = selected;
//      globals.obj.setImageFile(_imageFile);
//    });
//  }
//
//  /// Remove image
//  void _clear() {
//    setState(() => _imageFile = null);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      bottomNavigationBar: BottomAppBar(
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            IconButton(
//              icon: Icon(
//                Icons.photo_camera,
//                size: 30,
//              ),
//              onPressed: () => _pickImage(ImageSource.camera),
//              color: Colors.blue,
//            ),
//            IconButton(
//              icon: Icon(
//                Icons.photo_library,
//                size: 30,
//              ),
//              onPressed: () => _pickImage(ImageSource.gallery),
//              color: Colors.pink,
//            ),
//          ],
//        ),
//      ),
//      body: ListView(
//        children: <Widget>[
//          if (_imageFile != null) ...[
//            Container(
//                padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                FlatButton(
//                  color: Colors.black,
//                  child: Icon(Icons.crop),
//                  onPressed: _cropImage,
//                ),
//                FlatButton(
//                  color: Colors.black,
//                  child: Icon(Icons.refresh),
//                  onPressed: _clear,
//                ),
//              ],
//            ),
//            Padding(
//              padding: const EdgeInsets.all(32),
//              child: Uploader(
//                file: _imageFile,
//              ),
//            )
//          ]
//        ],
//      ),
//    );
//  }
//}
//
///// Widget used to handle the management of
//class Uploader extends StatefulWidget {
//  final File file;
//
//
//  Uploader({Key key, this.file}) : super(key: key);
//
//  createState() => _UploaderState();
//}
//
//class _UploaderState extends State<Uploader> {
//  final FirebaseStorage _storage =
//      FirebaseStorage(storageBucket: 'gs://b4di-b4d4c.appspot.com');
//
//  StorageUploadTask _uploadTask;
//
//  String fcm;
//  @override
//  void initState() {
//    super.initState();
//    setToken();
//  }
//
//  void setToken() async{
//    await FirebaseMessaging().getToken().then((token) {
//      //_prefs.setString("fcm_token", token);
//      fcm = token;
//    });
//  }
//
//  _startUpload() async {
//    print('starteUpload called');
//    String filePath = 'images/${DateTime.now()}.png';
//    _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
//    String url = await (await _uploadTask.onComplete).ref.getDownloadURL();
//    print("savepdf $url");
//    globals.seeker.setImageURL(url);
//    Firestore.instance.collection('Seeker').add({
//      "address": {
//        "address_line": globals.seeker.addressLine,
//        "city": globals.seeker.city,
//        "state": globals.seeker.state,
//        "pincode": globals.seeker.pincode,
//      },
//      "basic_details": {
//        "contact": globals.seeker.contact,
//        "email": globals.seeker.email,
//        "first_name": globals.seeker.firstName,
//        "gender": globals.seeker.gender,
//        "last_name": globals.seeker.lastName,
//      },
//      "basic_qualification": globals.seeker.qualification,
//      "experience": globals.seeker.experience,
//      "expertise": globals.seeker.expertise,
//      "category": globals.seeker.category,
//      "languages_known": globals.seeker.languages,
//      "ImageURL": globals.seeker.imageURL,
//      "fcm": fcm,
//      "approved": new List(),
//      "password": globals.seeker.password
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FlatButton.icon(
//      color: Colors.blue,
//      label: Text('Upload to Firebase'),
//      icon: Icon(Icons.cloud_upload),
//      onPressed: () {
//        _startUpload();
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => UserLogin("JobSeeker")),
//        );
//      },
//    );
//  }
//}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/userLogin.dart';

class SeekerImageUpload extends StatefulWidget {
  SeekerImageUpload({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SeekerImageUploadState createState() => _SeekerImageUploadState();
}

class _SeekerImageUploadState extends State<SeekerImageUpload> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
      globals.obj.setImageFile(_imageFile);
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
                "Please select an image of your aadhar",
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
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://b4di-b4d4c.appspot.com');

  StorageUploadTask _uploadTask;
  String fcm;
  @override
  void initState() {
    super.initState();
    setToken();
  }

  void setToken() async {
    await FirebaseMessaging().getToken().then((token) {
      //_prefs.setString("fcm_token", token);
      fcm = token;
    });
    subscribeToTopic();
  }

  void subscribeToTopic() async {
    for (var i = 0; i < globals.seeker.category.length; i++) {
      print("subscribing to category," + globals.seeker.category.elementAt(i));
      await FirebaseMessaging()
          .subscribeToTopic(globals.seeker.category.elementAt(i));
    }
  }

  _startUpload() async {
    print('starteUpload called');
    String filePath = 'images/${DateTime.now()}.png';
    _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    String url = await (await _uploadTask.onComplete).ref.getDownloadURL();
    print("savepdf $url");
    globals.seeker.setImageURL(url);
    Firestore.instance.collection('Seeker').add({
      "address": {
        "address_line": globals.seeker.addressLine,
        "city": globals.seeker.city,
        "state": globals.seeker.state,
        "pincode": globals.seeker.pincode,
      },
      "basic_details": {
        "contact": globals.seeker.contact,
        "email": globals.seeker.email,
        "first_name": globals.seeker.firstName,
        "gender": globals.seeker.gender,
        "last_name": globals.seeker.lastName,
      },
      "basic_qualification": globals.seeker.qualification,
      "experience": globals.seeker.experience,
      "expertise": globals.seeker.expertise,
      "category": globals.seeker.category,
      "languages_known": globals.seeker.languages,
      "ImageURL": globals.seeker.imageURL,
      "fcm": fcm,
      "approved": new List(),
      "password": globals.seeker.password
    });
  }

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
              //TODO: Disable the button until user selects an image
              Icon(Icons.file_upload,
                  semanticLabel: "Upload", color: Colors.white),
              SizedBox(width: 16.0),
              Text("Upload to ProSeekr", style: TextStyle(color: Colors.white)),
            ],
          )),
      onPressed: () {
        _startUpload();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserLogin("JobSeeker")),
        );
      },
    );
  }
}
