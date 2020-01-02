import 'package:flutter/material.dart';

import '../../models/globals.dart' as globals;
import 'jobs.dart';

class AppliedJobs extends StatefulWidget {
  final String user = globals.userId;

  @override
  _AppliedJobsState createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  Widget build(BuildContext context) {
    return Jobs("applied");
  }
}
