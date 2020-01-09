import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/seeker/app_drawer_view.dart';
import 'package:proseekr/src/views/seeker/jobs_view_handler.dart';
import 'package:proseekr/src/views/user_inbox_view.dart';

class Jobs extends StatefulWidget {
  final String user = globals.userId;
  final String searchKey;
  Jobs(this.searchKey);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  String title = "Jobs";
  CollectionReference ref = Firestore.instance.collection("Jobs");
  List<DocumentSnapshot> data;
  bool _loading = true;

  void _favIconChange(String jobId, index) {
    print("fav icon fucallled"); // TODO: Remove logs
    bool favourite = data[index]["favourite"].contains(widget.user);
    print(favourite); // TODO: Remove logs
    if (favourite == false) {
      print("adding document fav"); // TODO: Remove logs
      ref.document(jobId).updateData({
        "favourite": FieldValue.arrayUnion([widget.user])
      });
    } else {
      print("removing document fav"); // TODO: Remove logs
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
    print("jobs initstate"); // TODO: Remove logs
    Query q = ref;
    print(widget.searchKey); // TODO: Remove logs
    if (widget.searchKey == "favourite") {
      q = ref.where('favourite', arrayContains: widget.user);
      title = "Favourite Jobs";
    }
    if (widget.searchKey == "applied") {
      q = ref.where('applicants', arrayContains: widget.user);
      title = "Applied Jobs";
    }
    if (widget.searchKey == "approved") {
      print("approve jobs callled"); // TODO: Remove logs
      q = ref.where("approved", arrayContains: widget.user);
      title = "Approved Jobs";
    }
    QuerySnapshot querySnapshot = await q.getDocuments();
    data = querySnapshot.documents;
    setState(() {
      _loading = false;
    });
    print(data[0]); // TODO: Remove logs
    print(data.length); // TODO: Remove logs
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text(title),
              style: TextStyle(
                color: Colors.white,
              )),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          // elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color:
                      globals.hasNewMessage == true ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Inbox()));
                }),
          ],
        ),
        drawer: AppDrawer(),
        body: _loading == true
            ? Center(
                child:
                    Text(AppTranslations.of(context).text("Loading") + "..."),
              )
            : data.length == 0
                ? Center(
                    child: Text(AppTranslations.of(context).text("No Jobs")))
                : JobsUI(data, widget.user, widget.searchKey, _appliedForJobs,
                    _favIconChange),
      ),
    );
  }
}
