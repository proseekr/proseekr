import 'package:flutter/material.dart';
import 'jobs.dart';
import '../../models/globals.dart' as globals;

class FavJobCards extends StatefulWidget {
  String user=globals.userId;


  @override
  FavJobCardsState createState() => FavJobCardsState();
}

class FavJobCardsState extends State<FavJobCards> {
  @override
  Widget build(BuildContext context) {
    return Jobs("favourite");
  }
}
