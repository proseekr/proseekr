import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/provider/app_drawer_view.dart' as JPHamDraw;
import 'package:proseekr/src/views/seeker/app_drawer_view.dart' as JSHamDraw;
import 'package:proseekr/src/widgets/notification_card_builder.dart';

class Inbox extends StatefulWidget {
  final String user = globals.userId;
  final String role = globals.loggedInActor;

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  CollectionReference ref = Firestore.instance.collection("Jobs");
  bool _isLoading = true;
  DocumentSnapshot ds;

  @override
  void initState() {
    globals.hasNewMessage = false;
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
    print(widget.role); // TODO: Remove logs
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                ? JPHamDraw.AppDrawer()
                : JSHamDraw.AppDrawer(),
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
                    : NotificationCardBuilder(ds.data["messages"]))));
  }
}
