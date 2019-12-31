import 'package:flutter/material.dart';
import 'jobs.dart';
import '../../models/globals.dart' as globals;

class AppliedJobs extends StatefulWidget {
  String user=globals.userId;

  @override
  _AppliedJobsState createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  Widget build(BuildContext context) {
    return Jobs("applied");
  }
}
