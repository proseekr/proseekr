import 'package:flutter/material.dart';
import 'package:proseekr/app.dart';

void main() {
  print("App started");
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProSeeker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProSeekerApp(),
    );
  }
}
