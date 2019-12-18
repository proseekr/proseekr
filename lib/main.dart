import 'package:flutter/material.dart';
import 'package:proseekr/src/ui/languagePreferences.dart';

void main() => runApp(ProSeekerApp());

class ProSeekerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProSeekr',
      debugShowCheckedModeBanner: false,
      home: LanguagePreferences(title: 'Language Preferences'),
    );
  }
}
