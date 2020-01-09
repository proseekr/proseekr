import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/app_settings_view.dart';
import 'package:proseekr/src/views/seeker/applied_jobs_view.dart';
import 'package:proseekr/src/views/seeker/approved_jobs_view.dart';
import 'package:proseekr/src/views/seeker/favourite_jobs_view.dart';
import 'package:proseekr/src/views/seeker/seeker_feed.dart';
import 'package:proseekr/src/views/user_inbox_view.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String user = globals.userId;
  String name = "";
  String email = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print("init called"); // TODO: Remove logs
    _getData();
  }

  void _getData() async {
    print("getdata hamdraw"); // TODO: Remove logs
    await Firestore.instance
        .collection("Seeker")
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
    // TODO: Remove await
    _getData();
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
              title: Text(
                  AppTranslations.of(context).text("Apply For Jobs (Home)")),
              leading: Icon(Icons.add, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }),
          ListTile(
              title: Text(AppTranslations.of(context).text("Inbox")),
              leading: Icon(Icons.inbox, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Inbox()));
              }),
          ListTile(
              title: Text(AppTranslations.of(context).text("Favourite Jobs")),
              leading: Icon(Icons.favorite, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FavJobCards()));
              }),
          ListTile(
              title: Text(AppTranslations.of(context).text("Applied Jobs")),
              leading: Icon(Icons.account_box, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AppliedJobs()));
              }),
          ListTile(
              title: Text(AppTranslations.of(context).text("Approved Jobs")),
              leading: Icon(Icons.check, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ApprovedJobs()));
              }),
          ListTile(
              title: Text(AppTranslations.of(context).text("Settings")),
              leading: Icon(Icons.settings, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Settings()));
              }),
        ],
      ),
    );
  }
}
