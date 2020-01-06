import 'package:flutter/material.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/seeker/all_jobs_view.dart';

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
