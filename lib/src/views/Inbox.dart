import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/job_provider/HamDraw.dart' as JPHamDraw;
import 'package:proseekr/src/views/job_seeker/HamDraw.dart' as JSHamDraw;

import 'NotificationMessages.dart';

class Inbox extends StatefulWidget {
  String user = globals.userId;
  String role = globals.loggedInActor;

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  CollectionReference ref = Firestore.instance.collection("Jobs");
  bool _isLoading = true;
  DocumentSnapshot ds;

  @override
  void initState() {
    globals.newMessage = false;
    super.initState();
    getData();
  }

  void getData() async {
    String collection = "Provider_Inbox";
    if (widget.role == "Seeker") {
      collection = "Seeker_Inbox";
    }
    ds = await Firestore.instance
        .collection(collection)
        .document(widget.user)
        .get();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.role);
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: AppBar(
              title: Text(
                AppTranslations.of(context).text("Notification"),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.black,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.grey),
                  onPressed: null,
                ),
              ],
            ),
            drawer: widget.role == "Provider"
                ? JPHamDraw.HamDraw()
                : JSHamDraw.HamDraw(),
            body: _isLoading == true
                ? Center(
                    child: Text(
                        AppTranslations.of(context).text("loading") + "..."),
                  )
                : (ds != null || ds.data["messages"].length == 0
                    ? Center(
                        child: Text(AppTranslations.of(context)
                            .text("no new notifications")),
                      )
                    : NotificationMessages(ds.data["messages"]))));
  }
}
