import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'provider_feed.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:proseekr/src/models/globals.dart' as globals;

class TestLogin extends StatefulWidget{
  String actor;
  TestLogin(this.actor);
  @override
  _TestLoginState createState() => new _TestLoginState();
}

class _TestLoginState extends State<TestLogin>
{
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontSize: 14.0);
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  bool _autoValidate = false;
  static CollectionReference ref;
  List<DocumentSnapshot> data = new List<DocumentSnapshot>();
  bool valid = false;
  String docId = "";

  Future<void> validate(String username, String password) async{
  ref =  await Firestore.instance.collection(widget.actor);
  QuerySnapshot querySnapshot = await ref.getDocuments();
  data = querySnapshot.documents;
     for(var i=0; i < data.length; i++){
       print(data[i]['basic_details']['contact']);
       if(data[i]['basic_details']['contact'] == username){
         if(data[i]['password'] == password){
           valid = true;
           docId = data[i].documentID;
         }
         else{
           print("Please enter the credentials");
         }
       }
     }


  }

  @override
  Widget build(BuildContext context) {
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
    Padding(padding: EdgeInsets.all(globals.PADDING)),
      Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              obscureText: false,
              style: style,
              controller: _usernameFilter,
              decoration: InputDecoration(
                  prefixIcon: new Icon(Icons.person),
                  contentPadding: EdgeInsets.fromLTRB(
                      20.0, 15.0, 20.0, 15.0),
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(32.0))),
              validator: (value) {
                print('validator called');
                if (value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(globals.PADDING)),
          Expanded(
            child: TextFormField(
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
                  return 'Please enter your Password';
                }
                return null;
              },
            ),
          ),
          Padding(padding: EdgeInsets.all(globals.PADDING)),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.black,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                 validate(_usernameFilter.text, _passwordFilter.text);
                 if(valid){
                   print("Logged in");
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProviderFeed()),
                  );
                 }
                  else{
                    print("Please enter valid creds");
                  }

                }
              },
              child: Text("Next",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(padding: EdgeInsets.all(globals.PADDING)),
        ],
      ),
    ]
    )
    )
    )
    )
        )
    );
  }

}