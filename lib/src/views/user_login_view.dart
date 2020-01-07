import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/views/seeker/homefeed_view.dart';

import '../models/globals.dart' as globals;
import 'provider/provider_feed.dart';

class UserLogin extends StatefulWidget {
  final String actor;
  UserLogin(this.actor);
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String actor = "";

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();

  static CollectionReference ref;
  List<DocumentSnapshot> data = List<DocumentSnapshot>();
  bool valid = false;
  String docId = "";
  bool _invalidCreds = false;

  Future<void> validate(String username, String password) async {
    print("actor" + widget.actor.toString()); // TODO: Remove logs
    print("globals" +
        globals.SelectedActor.JobProvider.toString()); // TODO: Remove logs
    if (widget.actor.toString() == 'JobProvider')
      actor = 'Provider';
    else
      actor = 'Seeker';
    print("log in page" + actor); // TODO: Remove logs
    ref = Firestore.instance.collection(actor);
    QuerySnapshot querySnapshot = await ref.getDocuments();
    data = querySnapshot.documents;
    for (var i = 0; i < data.length; i++) {
      print(data[i]['basic_details']['contact']); // TODO: Remove logs
      if (data[i]['basic_details']['contact'] == username) {
        if (data[i]['password'] == password) {
          _invalidCreds = false;
          docId = data[i].documentID;
          globals.userId = docId;
          globals.loggedInActor = actor;
        } else {
          print("Please enter the right password"); // TODO: Remove logs
          _invalidCreds = true;
        }
      }
    }
  }

  void _showDialog() {
    print('show dialog called'); // TODO: Remove logs
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invalid Credentials"),
          content: Text("Please enter valid credentials"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //    print(globals.obj.firstName); // TODO: Remove logs
    //    void validatePassword() {}
    bool _autoValidate = false;
    TextStyle style = TextStyle(fontSize: 18.0);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.black,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: KeyboardAvoider(
                autoScroll: true,
                child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(globals.PADDING)),
                          Center(
                            child:
                                Text("Login", style: TextStyle(fontSize: 24.0)),
                          ),
                          Padding(padding: EdgeInsets.all(globals.PADDING)),
                          TextFormField(
                            obscureText: false,
                            style: TextStyle(color: Colors.white),
                            controller: _usernameFilter,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                    Icon(Icons.call, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText:
                                    AppTranslations.of(context).text("contact"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              print('validator called'); // TODO: Remove logs
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(globals.PADDING)),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            controller: _passwordFilter,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("password"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              print('validator called'); // TODO: Remove logs
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(globals.PADDING)),
                          Center(
                            child: Material(
                              elevation: 8.0,
                              borderRadius: BorderRadius.circular(4.0),
                              color: Colors.black,
                              child: MaterialButton(
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.3,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await validate(_usernameFilter.text,
                                        _passwordFilter.text);
                                    if (_invalidCreds == false) {
                                      print("Logged in"); // TODO: Remove logs
                                      if (actor == 'Provider') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProviderFeed()),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                        );
                                      }
                                    } else {
                                      _showDialog();
                                    }
                                  }
                                },
                                child: Text(
                                    AppTranslations.of(context).text("login"),
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }

  void dispose() {
    _usernameFilter.dispose();
    _passwordFilter.dispose();
    super.dispose();
  }
}
