import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../resources/globals.dart' as globals;

class Credentials extends StatefulWidget {
  Credentials({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _confirmPasswordFilter =
      new TextEditingController();
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    //    print(globals.obj.firstName);
    //    void validatePassword() {}
    bool _autoValidate = false;
    TextStyle style = TextStyle(fontSize: 18.0);

    void _showDialog() {
      Fluttertoast.showToast(
          msg: "All fields are required",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Text("proseekr"),
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
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                          Center(
                            child: Text("Login", style: style),
                          ),
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                          TextFormField(
                            obscureText: false,
                            style: style,
                            controller: _usernameFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "User Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                          TextFormField(
                            obscureText: true,
                            style: style,
                            controller: _passwordFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                          TextFormField(
                            obscureText: true,
                            style: style,
                            controller: _confirmPasswordFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.black,
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Previous",
                                        textAlign: TextAlign.center,
                                        style: style.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.black,
                                  child: MaterialButton(
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.3,
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Credentials()),
                                        );
                                      } else {
                                        _showDialog();
                                      }
                                    },
                                    child: Text("Next",
                                        textAlign: TextAlign.center,
                                        style: style.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]),
                          Padding(
                              padding: EdgeInsets.all(globals.paddingValue)),
                        ],
                      ),
                    )))));
  }

  void dispose() {
    _usernameFilter.dispose();
    _passwordFilter.dispose();
    _confirmPasswordFilter.dispose();
    super.dispose();
  }
}
