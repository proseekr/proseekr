import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/views/job_provider/userLogin.dart';

import '../../models/globals.dart' as globals;

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  FileType _pickingType;
  String _filePath;
  File _selectedFile;
//  String _documentURL = "";
  bool _multiPick = false;
  bool _hasValidMime = false;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: globals.STORAGE_BUCKET_URL);

  StorageUploadTask _uploadTask;

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  final mainReference = FirebaseDatabase.instance.reference().child('B4DI');
  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
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
    print(fileName);
    print('${file.readAsBytesSync()}');
    _showDialog(_filePath);
  }

  Future savePdf(File pdf, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putFile(pdf);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
    print("savepdf $url");
    globals.obj.setDocumentURL(url);
  }

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  void _showDialog(selectedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Selected file ' + '"' + selectedFile + '"'),
          content: new Text(
              "You can change the file by clicking on upload documents button."),
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
    _uploadTask = _storage.ref().child(filePath).putFile(globals.obj.imageFile);
    String url = await (await _uploadTask.onComplete).ref.getDownloadURL();
    print("savepdf $url");
    globals.obj.setImageURL(url);
    print("push data " + globals.obj.toString());
    await Firestore.instance.collection('Provider').add({
      "address": {
        "address_line": globals.obj.addressLine,
        "city": globals.obj.city,
        "state": globals.obj.state,
        "pincode": globals.obj.pincode,
      },
      "basic_details": {
        "contact": globals.obj.contact,
        "email": globals.obj.email,
        "first_name": globals.obj.firstName,
        "gender": globals.obj.gender,
        "last_name": globals.obj.lastName,
        "store_name": globals.obj.storeName,
      },
      "DocumentURL": globals.obj.documentURL,
      "ImageURL": globals.obj.imageURL,
    });
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.grey[250],
              title: const Text('ProSeekr'),
            ),
            body: Center(
                child: Column(
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "btn1",
                  child: Text("Upload Document"),
                  backgroundColor: Colors.black,
//                child: Icon(Icons.arrow_back, color: Colors.white,) ,
                  onPressed: () {
                    getPdfAndUpload();
                  },
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  child: Text("Register"),
                  backgroundColor: Colors.black,
//                child: Icon(Icons.arrow_back, color: Colors.white,) ,
                  onPressed: () {
                    pushData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserLogin()),
                    );
                  },
                ),
              ],
            ))));
  }
}
