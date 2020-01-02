import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proseekr/src/views/job_provider/jobPosting.dart';
import 'package:proseekr/src/views/job_provider/provider_feed.dart';
import 'package:proseekr/src/views/settings.dart';

import '../../models/globals.dart' as globals;
import '../Inbox.dart';

class HamDraw extends StatefulWidget {
  @override
  _HamDrawState createState() => _HamDrawState();
}

class _HamDrawState extends State<HamDraw> {
  String user = globals.userId;
  String name = "", email = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    print("getdata hamdraw");
    await Firestore.instance
        .collection("Provider")
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
    return Drawer(
      child: new ListView(
        children: <Widget>[
//          Container(
//            color: Colors.black,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: _isLoading == false
//                      ? Text(name,
//                          style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
//                              fontSize: 24.0))
//                      : Text("Undefined username",
//                          style: TextStyle(color: Colors.white)),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(
//                      top: 0, left: 8.0, right: 8.0, bottom: 8.0),
//                  child: _isLoading == false
//                      ? Text(email, style: new TextStyle(color: Colors.white70))
//                      : Text("Undefined email",
//                          style: new TextStyle(color: Colors.white70)),
//                ),
//                SizedBox(height: 8.0),
//                Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: InkWell(
//                        child: Text(
//                          "Logout",
//                          style: TextStyle(
//                            color: Colors.white,
//                            fontSize: 18.0,
//                          ),
//                        ),
//                        onTap: () {
//                          print("Logout triggered");
//                          Navigator.of(context).push(MaterialPageRoute( //TODO logout
//                              builder: (BuildContext context) =>
//                                  ActorSelector()));
//                        })),
//                SizedBox(height: 8.0),
//              ],
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
              title: new Text("Home"),
              leading: new Icon(Icons.home, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ProviderFeed()));
              }),
          new ListTile(
              title: new Text("Upload a Job Profile"),
              leading: new Icon(Icons.work, color: Colors.black),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => JobPosting()));
              }),
          new ListTile(
              title: new Text("Inbox"),
              leading: new Icon(Icons.inbox,
                  color:
                      globals.newMessage == false ? Colors.black : Colors.red),
              onTap: () {
//                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
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
