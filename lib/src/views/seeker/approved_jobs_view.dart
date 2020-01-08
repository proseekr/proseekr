import 'package:flutter/material.dart';
import 'package:proseekr/src/views/seeker/all_jobs_view.dart';

class ApprovedJobs extends StatefulWidget {
  @override
  _ApprovedJobsState createState() => _ApprovedJobsState();
}

class _ApprovedJobsState extends State<ApprovedJobs> {
  @override
  Widget build(BuildContext context) {
    return Jobs("approved");
  }
}
