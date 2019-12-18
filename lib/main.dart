import 'package:flutter/material.dart';
import 'package:proseekr/src/ui/PsLanguagePreferences.dart';

void main() => runApp(ProSeekerApp());

class ProSeekerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProSeekr',
      debugShowCheckedModeBanner: false,
      home: PsLanguagePreferences(title: 'Home Page'),
    );
  }
}
