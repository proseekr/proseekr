import 'package:flutter/material.dart';
import 'jobs.dart';

class AppliedJobs extends StatefulWidget {
  String user;
  AppliedJobs(this.user);

  @override
  _AppliedJobsState createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  Widget build(BuildContext context) {
    return Jobs(widget.user,"applied");
  }
}
