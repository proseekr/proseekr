import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/app_settings_view.dart';
import 'package:proseekr/src/views/provider/post_job_view.dart';
import 'package:proseekr/src/views/provider/provider_feed.dart';
import 'package:proseekr/src/views/user_inbox_view.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String user = globals.userId;
  String name = "", email = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print("getdata hamdraw"); // TODO: Remove logs
    await Firestore.instance
        .collection("Provider")
        .document(user)
        .get()
        .then((n) {
      name = n.data['basic_details']['first_name'] +
          " " +
          n.data['basic_details']['last_name'];
      email = n.data['basic_details']['email'];
      print("hamdraw" + name); // TODO: Remove logs
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: _isLoading == false
                ? Text(name, style: TextStyle(color: Colors.white))
                : Text("Undefined name", style: TextStyle(color: Colors.white)),
            accountEmail: _isLoading == false
                ? Text(email, style: TextStyle(color: Colors.white))
                : Text("Undefined email",
                    style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_outline),
            ),
          ),
          ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ProviderFeed()));
              }),
          ListTile(
              title: new Text("Upload a Job Profile"),
              leading: new Icon(Icons.work, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => JobPosting()));
              }),
          ListTile(
              title: Text("Inbox"),
              leading: Icon(Icons.inbox,
                  color: globals.hasNewMessage == false
                      ? Colors.black
                      : Colors.blue),
              onTap: () {
//                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Inbox()));
              }),
          new ListTile(
              title: new Text("Settings"),
              leading: new Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Settings()));
              }),
        ],
      ),
    );
  }
}
