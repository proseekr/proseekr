import 'package:flutter/material.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/seeker/all_jobs_view.dart';

class FavJobCards extends StatefulWidget {
  final String user = globals.userId;

  @override
  FavJobCardsState createState() => FavJobCardsState();
}

class FavJobCardsState extends State<FavJobCards> {
  @override
  Widget build(BuildContext context) {
    return Jobs("favourite");
  }
}
