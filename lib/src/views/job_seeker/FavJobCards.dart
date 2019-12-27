import 'package:flutter/material.dart';
import 'jobs.dart';

class FavJobCards extends StatefulWidget {
  String user;
  FavJobCards(this.user);

  @override
  FavJobCardsState createState() => FavJobCardsState();
}

class FavJobCardsState extends State<FavJobCards> {
  @override
  Widget build(BuildContext context) {
    return Jobs(widget.user,"favourite");
  }
}
