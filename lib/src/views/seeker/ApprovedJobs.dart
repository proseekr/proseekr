import 'package:flutter/material.dart';
import 'jobs.dart';


class ApprovedJobs extends StatefulWidget {
  //String user;


  @override
  _ApprovedJobsState createState() => _ApprovedJobsState();
}

class _ApprovedJobsState extends State<ApprovedJobs> {
  @override
  Widget build(BuildContext context) {
    return Jobs("approved");
  }
}
