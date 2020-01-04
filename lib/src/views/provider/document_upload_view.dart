import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/config.cfg' as config;
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/user_login_view.dart';

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: config.STORAGE_BUCKET_URL);

  String _fileName, _filePath;
  File _selectedFile;
  StorageUploadTask _uploadTask;
  String fcmToken;

  void setToken() async {
    await FirebaseMessaging().getToken().then((token) {
      //_prefs.setString("fcm_token", token);
      fcmToken = token;
    });
  }

  @override
  void initState() {
    super.initState();
    setToken();
  }

  final mainReference =
      FirebaseDatabase.instance.reference().child(config.PROJECT_NAME);
  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100)); // TODO: Remove logs
      randomName += rng.nextInt(100).toString();
    }
    File file =
        await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
    _selectedFile = file;
    _filePath = file.path;
    List<String> filepath = _filePath.split('/');
    _filePath = filepath[filepath.length - 1];
    String fileName = '$randomName.pdf';
    _fileName = fileName;
    print(fileName); // TODO: Remove logs
    print('${file.readAsBytesSync()}'); // TODO: Remove logs
    _showDialog(_filePath);
  }

  Future savePdf(File pdf, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putFile(pdf);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print("savepdf $url"); // TODO: Remove logs
    globals.provider.setDocumentURL(url);
  }

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath); // TODO: Remove logs
      setState(() {
        this._filePath = filePath;
      });
    } catch (e) {
      print(
          "Error while picking the file: " + e.toString()); // TODO: Remove logs
    }
  }

  void _showDialog(selectedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Selected file ' + '"' + selectedFile + '"'),
          content: new Text(
              "You can change the file by clicking on 'Select a PDF file' button."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pushData() async {
    await savePdf(_selectedFile, _fileName);
    String filePath = 'images/${DateTime.now()}.png';
    _uploadTask =
        _storage.ref().child(filePath).putFile(globals.provider.imageFile);
    String url = await (await _uploadTask.onComplete).ref.getDownloadURL();
    print("savepdf $url"); // TODO: Remove logs
    globals.provider.setImageURL(url);
    print("push data " + globals.provider.toString()); // TODO: Remove logs
    await Firestore.instance.collection('Provider').add({
      "address": {
        "address_line": globals.provider.addressLine,
        "city": globals.provider.city,
        "state": globals.provider.state,
        "pincode": globals.provider.pincode,
      },
      "basic_details": {
        "contact": globals.provider.contact,
        "email": globals.provider.email,
        "first_name": globals.provider.firstName,
        "gender": globals.provider.gender,
        "last_name": globals.provider.lastName,
        "store_name": globals.provider.storeName,
      },
      "DocumentURL": globals.provider.documentURL,
      "ImageURL": globals.provider.imageURL,
      "fcm": fcmToken,
      "Jobs": new List(),
      "password": globals.provider.password
    });
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: const Text('Upload document'),
          leading: Icon(Icons.arrow_back, color: Colors.white),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Colors.black,
              elevation: 8.0,
              child: Container(
                  height: 48.0,
                  width: 160.0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.folder_open,
                          semanticLabel:
                              "Select a document of the residential proof",
                          color: Colors.white),
                      SizedBox(width: 16.0),
                      Text("Select a PDF file",
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
              onPressed: () {
                getPdfAndUpload();
              },
            ),
            SizedBox(height: 24.0),
            RaisedButton(
              color: Colors.black,
              elevation: 8.0,
              child: Container(
                  height: 48.0,
                  width: 160.0,
                  child: Row(
                    children: <Widget>[
                      //TODO: Disable the button until user selects a pdf
                      Icon(Icons.file_upload,
                          semanticLabel: "Submit", color: Colors.white),
                      SizedBox(width: 16.0),
                      Text("Upload to ProSeekr",
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
              onPressed: () async {
                // TODO: Remove await
                pushData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserLogin("JobProvider")),
                );
              },
            ),
          ],
        )));
  }
}
