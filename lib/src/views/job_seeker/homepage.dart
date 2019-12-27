import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../src/views/job_seeker/jobs.dart';

int len;

class HomePage extends StatefulWidget {
  String user;
  HomePage(this.user);
  HomePage.direct();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Jobs(widget.user, "jobs");
  }
}
