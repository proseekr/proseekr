import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/views/job_seeker/HamDraw.dart';
import 'package:proseekr/src/views/job_seeker/JobsUI.dart';
import 'package:proseekr/src/views/job_seeker/NotificationMessages.dart';

class Jobs extends StatefulWidget {
  String user;
  String searchKey;
  Jobs(this.user, this.searchKey);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  CollectionReference ref = Firestore.instance.collection("Job");
  List<DocumentSnapshot> data;
  bool _loading = true;

  void _favIconChange(String jobId, index) {
    print("fav icon fucallled");
    bool favourite = data[index]["favourite"].contains(widget.user);
    print(favourite);
    if (favourite == false) {
      print("adding document fav");
      ref.document(jobId).updateData({
        "favourite": FieldValue.arrayUnion([widget.user])
      });
    } else {
      print("removing document fav");
      ref.document(jobId).updateData({
        "favourite": FieldValue.arrayRemove([widget.user])
      });
    }
    setState(() {
      _loading = true;
      _getData();
    });
  }

  void _appliedForJobs(String jobId, index) {
    bool applied = data[index]["applicants"].contains(widget.user);
    if (applied == false) {
      ref.document(jobId).updateData({
        "applicants": FieldValue.arrayUnion([widget.user])
      });
    } else {
      ref.document(jobId).updateData({
        "applicants": FieldValue.arrayRemove([widget.user])
      });
    }
    setState(() {
      _loading = true;
      _getData();
    });
  }

  void _getData() async {
    print("jobs initstate");
    Query q = ref;
    print(widget.searchKey);
    if (widget.searchKey == "favourite") {
      q = ref.where('favourite', arrayContains: widget.user);
    }
    if (widget.searchKey == "applied") {
      q = ref.where('applicants', arrayContains: widget.user);
    }
    QuerySnapshot querySnapshot = await q.getDocuments();
    data = querySnapshot.documents;
    setState(() {
      _loading = false;
    });
    print(data[0]);
    print(data.length);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text("B4DI",
                  style: new TextStyle(color: Colors.black, fontFamily: 'Pop')),
              iconTheme: new IconThemeData(color: Colors.black),
              backgroundColor: Colors.blue,
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(
                      Icons.notifications_active,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NotificationMessages(widget.user)));
                    }),
                new IconButton(icon: new Icon(Icons.search), onPressed: null)
              ],
            ),
            drawer: HamDraw(widget.user),
            body: _loading == true
                ? Center(
                    child: Text("loading..."),
                  )
                : JobsUI(data, widget.user, _appliedForJobs, _favIconChange)));
  }
}
