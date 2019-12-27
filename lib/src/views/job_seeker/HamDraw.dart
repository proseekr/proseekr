import 'package:flutter/material.dart';
import 'package:proseekr/src/views/job_seeker/FavJobCards.dart';
import 'package:proseekr/src/views/job_seeker/appliedJobs.dart';
import 'package:proseekr/src/views/job_seeker/homepage.dart';

class HamDraw extends StatelessWidget {
  String user;
  HamDraw(this.user);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text(
              "Ram Gopal Varma",
              style: new TextStyle(color: Colors.black),
            ),
            accountEmail: new Text("alluriramgopalvarma@gmail.com",
                style: new TextStyle(color: Colors.black)),
            decoration: new BoxDecoration(color: Colors.blue[50]),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          new ListTile(
              title: new Text("Apply For Jobs (Home)"),
              leading: new Icon(Icons.add, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(user)));
              }),
          new ListTile(
              title: new Text("Verify Details"),
              leading: new Icon(Icons.verified_user, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Inbox"),
              leading: new Icon(Icons.inbox, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Favourite Jobs"),
              leading: new Icon(Icons.favorite, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => FavJobCards(user)));
              }),
          new ListTile(
              title: new Text("Update Deatails"),
              leading: new Icon(Icons.update, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Applied Jobs"),
              leading: new Icon(Icons.account_box, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AppliedJobs(user)));
              }),
          new ListTile(
              title: new Text("Jobs Approved "),
              leading: new Icon(Icons.check, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Settings"),
              leading: new Icon(Icons.settings, color: Colors.blueAccent),
              onTap: () {
                Navigator.of(context).pop();
              }),
          new ListTile(
              title: new Text("Like us Give Us Rating"),
              leading: new Icon(Icons.thumb_up, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
