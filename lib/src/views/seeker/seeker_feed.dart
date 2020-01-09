import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/seeker/all_jobs_view.dart';

class HomePage extends StatefulWidget {
  final String user = globals.userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("#onMessage: $message"); // TODO: Remove logs
        print("message showed"); // TODO: Remove logs
        globals.hasNewMessage = true;
        print("message showed"); // TODO: Remove logs
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message"); // TODO: Remove logs
        globals.hasNewMessage = true;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message"); // TODO: Remove logs
        globals.hasNewMessage = true;
        AlertDialog(content: Text("onResume: $message"));
      },
    );
    super.initState();
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("fcm token" + token); // TODO: Remove logs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Jobs("jobs");
  }
}
