import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';

import '../../models/globals.dart' as globals;
import '../Inbox.dart';
import 'HamDraw.dart';
import 'JobsUI.dart';

class Jobs extends StatefulWidget {
  String user = globals.userId;
  String searchKey;
  String title = "Jobs";
  Jobs(this.searchKey);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  CollectionReference ref = Firestore.instance.collection("Jobs");
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
      widget.title = "Favourite Jobs";
    }
    if (widget.searchKey == "applied") {
      q = ref.where('applicants', arrayContains: widget.user);
      widget.title = "Applied Jobs";
    }
    if (widget.searchKey == "approved") {
      print("approve jobs callled");
      q = ref.where("approved", arrayContains: widget.user);
      widget.title = "Approved Jobs";
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
              title: new Text(AppTranslations.of(context).text(widget.title),
                  style: new TextStyle(
                    color: Colors.white,
                  )),
              iconTheme: new IconThemeData(color: Colors.white),
              backgroundColor: Colors.black,
//              elevation: 0,
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(
                      Icons.notifications_none,
                      color:
                          globals.newMessage == true ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Inbox()));
                    }),
              ],
            ),
            drawer: HamDraw(),
            body: _loading == true
                ? Center(
                    child: Text(
                        AppTranslations.of(context).text("Loading") + "..."),
                  )
                : data.length == 0
                    ? Center(
                        child:
                            Text(AppTranslations.of(context).text("No Jobs")))
                    : JobsUI(data, widget.user, widget.searchKey,
                        _appliedForJobs, _favIconChange)));
  }
}
