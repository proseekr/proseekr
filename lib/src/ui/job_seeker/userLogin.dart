import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class UserLogin extends StatefulWidget {
  UserLogin({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  String _username = "";
  String _password = "";

  void dispose() {
    _usernameFilter.dispose();
    _passwordFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 18.0);
    final usernameField = TextField(
      obscureText: false,
      style: style,
      controller: _usernameFilter,
      decoration: InputDecoration(
          prefixIcon: new Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: _passwordFilter,
      decoration: InputDecoration(
          prefixIcon: new Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.black,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _username = _usernameFilter.text;
          _password = _passwordFilter.text;
          print(_username);
          print(_password);
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Text("proseekr"),
        ),
        body: Container(
            padding: EdgeInsets.all(30),
            child: KeyboardAvoider(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ProSeekr',
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    'A job portal for blue-collars',
                    style: TextStyle(fontSize: 18),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 24.0)),
                  SizedBox(height: 45.0),
                  usernameField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ))));
  }
}
