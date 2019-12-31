import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/globals.dart' as globals;
import 'jobs.dart';

int len;

class HomePage extends StatefulWidget {
  String user = globals.userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("#onMessage: $message");
        print("message showed");
        globals.newMessage = true;
        print("message showed");
        //  Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomePage()),
        //     );
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        globals.newMessage = true;
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage()),
//        );
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        globals.newMessage = true;
        AlertDialog(content: Text("onResume: $message"));
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage()),
//        );
        //_navigateToItemDetail(message);
      },
    );
    super.initState();
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("fcm token" + token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Jobs("jobs");
  }
}
