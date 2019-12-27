import 'package:flutter/material.dart';
import 'package:proseekr/src/views/job_seeker/HamDraw.dart';

class NotificationMessages extends StatelessWidget {
  String user;
  NotificationMessages(this.user);
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => true,
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text("B4DI",
                  style: new TextStyle(color: Colors.black, fontFamily: 'Pop')),
              iconTheme: new IconThemeData(color: Colors.black),
              backgroundColor: Colors.blue,
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(
                      Icons.notifications_none,
                      color: Colors.grey,
                    ),
                    onPressed: null),
                new IconButton(icon: new Icon(Icons.search), onPressed: null)
              ],
            ),
            drawer: HamDraw(user),
            body: ListView(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(1),
                        child: Text(
                          "Job Alert!",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          "New Physical labor job has been added",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(1),
                        child: Text(
                          "Topic subscription!",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 7, 7),
                        child: Text(
                          "You have been subscribed to plumber ,physical labor categories!",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(1),
                        child: Text(
                          "Welcome Message!",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          "There's some information to get you started",
                          style: TextStyle(color: Colors.black45, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
