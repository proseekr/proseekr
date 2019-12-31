import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/views/settings.dart';

import '../../models/globals.dart' as globals;
import '../Inbox.dart';
import 'ApprovedJobs.dart';
import 'FavJobCards.dart';
import 'appliedJobs.dart';
import 'homepage.dart';

class HamDraw extends StatefulWidget {
  @override
  _HamDrawState createState() => _HamDrawState();
}

class _HamDrawState extends State<HamDraw> {
  String user = globals.userId;
  String name = "";
  String email = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("init called");
    _getData();
  }

  void _getData() async {
    print("getdata hamdraw");
    await Firestore.instance
        .collection("Seeker")
        .document(user)
        .get()
        .then((n) {
      name = n.data['basic_details']['first_name'] +
          " " +
          n.data['basic_details']['last_name'];
      email = n.data['basic_details']['email'];
      print("hamdraw" + name);
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    () async {
      await _getData();
    };
    return Drawer(
      child: new ListView(
        children: <Widget>[
//          new UserAccountsDrawerHeader(
//            accountName: new Text(
//              name,
//              style: new TextStyle(color: Colors.white),
//            ),
//            accountEmail:
//                new Text(email, style: new TextStyle(color: Colors.white)),
//            decoration: new BoxDecoration(color: Colors.black),
//            currentAccountPicture: CircleAvatar(
//              backgroundColor: Colors.white,
//              child: Text(
//                "A",
//                style: TextStyle(fontSize: 40.0, color: Colors.black),
//              ),
//            ),
//          ),
          new UserAccountsDrawerHeader(
            accountName: _isLoading == false
                ? Text(name, style: TextStyle(color: Colors.white))
                : Text("Undefined name", style: TextStyle(color: Colors.white)),
            accountEmail: _isLoading == false
                ? Text(email, style: new TextStyle(color: Colors.white))
                : Text("Undefined email",
                    style: new TextStyle(color: Colors.white)),
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_outline),
            ),
          ),
          new ListTile(
              title: new Text(
                  AppTranslations.of(context).text("Apply For Jobs (Home)")),
              leading: new Icon(Icons.add, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }),

          new ListTile(
              title: new Text(AppTranslations.of(context).text("Inbox")),
              leading: new Icon(Icons.inbox, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Inbox())); //TODO make notification icon in hamdraw red
              }),
          new ListTile(
              title:
                  new Text(AppTranslations.of(context).text("Favourite Jobs")),
              leading: new Icon(Icons.favorite, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => FavJobCards()));
              }),
          new ListTile(
              title: new Text(AppTranslations.of(context).text("Applied Jobs")),
              leading: new Icon(Icons.account_box, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AppliedJobs()));
              }),
          new ListTile(
              title:
                  new Text(AppTranslations.of(context).text("Approved Jobs")),
              leading: new Icon(Icons.check, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ApprovedJobs()));
              }),
          new ListTile(
              title: new Text(AppTranslations.of(context).text("Settings")),
              leading: new Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Settings()));
              }),
        ],
      ),
    );
  }
}
