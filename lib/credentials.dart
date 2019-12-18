import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tempForm.dart';

class credentials extends StatefulWidget {
  credentials({Key Key, this.title}) : super(key: Key);
  final String title;

  @override
  _credentialsState createState() => _credentialsState();
}

class _credentialsState extends State<credentials> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _confirmPasswordFilter = new TextEditingController();
  String _username = "";
  String _password = "";


  void dispose() {
    _usernameFilter.dispose();
    _passwordFilter.dispose();
    _confirmPasswordFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(globals.obj.firstName);

    TextStyle style = TextStyle(fontSize: 18.0);
    void validate_password(){

    }
    void _showDialog() {
      // flutter defined function
      Fluttertoast.showToast(
          msg: "Please enter all the fields",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    bool _autoValidate = false;
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
                          Padding(padding: EdgeInsets.all(globals.padding_value)),
                          Center(
                            child: Text("Login", style: style),
                          ),
                          Padding(padding: EdgeInsets.all(globals.padding_value)),


                          TextFormField(
                            obscureText: false,
                            style: style,
                            controller: _usernameFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintText: "User Name",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),

                          Padding(padding: EdgeInsets.all(globals.padding_value)),

                          TextFormField(
                            obscureText: true,
                            style: style,
                            controller: _passwordFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(globals.padding_value)),
                          TextFormField(
                            obscureText: true,
                            style: style,
                            controller: _confirmPasswordFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.person),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(padding: EdgeInsets.all(globals.padding_value)),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.black,
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width*0.3,
                                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Previous",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                          color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.black,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width*0.3,
                                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                                onPressed: () {
                                  if(_formKey.currentState.validate()){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => credentials()),
                                    );
                                  }
                                  else {
                                    _showDialog();
                                  }

                                },
                                child: Text("Next",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            ]
                          ),

                          Padding(padding: EdgeInsets.all(globals.padding_value)),
                        ],
                      ),


                    )))));
  }
}
