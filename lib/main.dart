import 'package:flutter/material.dart';
import 'package:proseekr/app.dart';

void main() {
  print("App started"); //TODO: Remove logs
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProSeeker',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ProSeekerApp(),
    );
  }
}
