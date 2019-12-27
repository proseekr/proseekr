import 'package:flutter/material.dart';
import 'package:proseekr/app.dart';

void main() {
  print("App started");
//  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProFeed());
}

class ProFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase: ProSeeker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProSeekerApp(),
    );
  }
}
