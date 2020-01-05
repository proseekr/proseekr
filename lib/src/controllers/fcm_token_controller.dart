import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(FCMTest());

class FCMTest extends StatefulWidget {
  _FCMTestState createState() => _FCMTestState();
}

class _FCMTestState extends State<FCMTest> {
  String _fcmToken;

  @override
  void initState() {
    super.initState();
    FCMTokenController.getFcmToken().then((token) {
      setState(() {
        _fcmToken = token;
      });
    });
  }

  Widget build(BuildContext ctx) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(_fcmToken ?? 'FCM_token'),
        ),
      ),
    );
  }
}

class FCMTokenController {
  static SharedPreferences _prefs;

  static Future<SharedPreferences> getSPInstance() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  FCMTokenController() {
    getSPInstance();
  }

  static bool isSetToken() {
    return _prefs.containsKey("fcm_token");
  }

  static Future<String> getFcmToken() async {
    var fcmToken;
    if (!isSetToken()) {
      await FirebaseMessaging().getToken().then((token) {
        _prefs.setString("fcm_token", token);
        fcmToken = token;
      });
    } else {
      fcmToken = _prefs.get("fcm_token");
    }
    return fcmToken;
  }
}
