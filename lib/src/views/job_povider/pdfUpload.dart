import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../resources/globals.dart' as globals;
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'userLogin.dart';

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
  String _documentURL="";
  bool _multiPick = false;
  bool _hasValidMime = false;
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://b4di-b4d4c.appspot.com');

  StorageUploadTask _uploadTask;

  TextEditingController _controller = new TextEditingController();

final mainReference = FirebaseDatabase.instance.reference().child('B4DI');
  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    File file = await FilePicker.getFile(
        type: FileType.CUSTOM, fileExtension: 'pdf');
    _selectedFile = file;
    _filePath = file.path;
   List<String> filepath = _filePath.split('/');
    _filePath = filepath[filepath.length-1];
    String fileName = '${randomName}.pdf';
    _fileName = fileName;
    print(fileName);
    print('${file.readAsBytesSync()}');
    _showDialog(_filePath);
  }

  Future savePdf(List<int> asset, String name) async {
    StorageReference reference = FirebaseStorage.instance.ref().child(name);
    StorageUploadTask uploadTask = reference.putData(asset);
    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
 setState(() {
   _documentURL=url;
 });
  }


  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState((){this._filePath = filePath;});
    }  catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }
//void documentFileUpload(String str) {
//
//  var data = {
//    "PDF": str,
//  };
//  mainReference.child("Documents").child('pdf').set(data).then((v) {
//  });
//}
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }
  void _showDialog(selectedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Selected file '+'"'+selectedFile+'"'),
          content: new Text("You can change the file by clicking on upload documents button."),
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
void pushData() {
  savePdf(_selectedFile.readAsBytesSync(), _fileName);
  globals.obj.setDocumentURL(_documentURL);
  print(globals.obj.documentURL);
  String filePath = 'images/${DateTime.now()}.png';
  setState(() {
    print('setState called');
    _uploadTask = _storage.ref().child(filePath).putFile(globals.obj.imageFile);
  });
  print(globals.obj.toString());
  Firestore.instance
      .collection('Provider')
      .add({
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
    "DocumentURL": _documentURL,
    "ImageURL": "TestURL"
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
                child: Text( "Upload Document"),
                backgroundColor: Colors.black,
//                child: Icon(Icons.arrow_back, color: Colors.white,) ,
                onPressed: () {
                  getPdfAndUpload();

                },
              ),

           FloatingActionButton(
          heroTag: "btn2",
          child: Text( "Register"),
          backgroundColor: Colors.black,
//                child: Icon(Icons.arrow_back, color: Colors.white,) ,
          onPressed: () {
            pushData();
            Navigator.push(
            context,
    MaterialPageRoute(builder: (context) =>
    UserLogin()),);

          },
        ),
          ],
              )
            )
    )
    );
  }
}


