import "package:flutter/material.dart";
import 'package:proseekr/src/ui/job_povider/userLogin.dart';

import 'job_povider/userRegistration.dart';
import 'job_seeker/seekerRegistration.dart';

enum SelectedActor { JobProvider, JobSeeker }

class ActorSelector extends StatefulWidget {
  ActorSelector({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ActorSelectorState createState() => _ActorSelectorState();
}

class _ActorSelectorState extends State<ActorSelector> {
  SelectedActor _character = SelectedActor.JobProvider;
  Widget build(BuildContext context) {
    final signIn = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLogin()),
              );
            },
            child: Text(
              "Sign-in",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )));
    final signUp = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              print("UserRegistration called");
              if (_character == SelectedActor.JobProvider) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserRegistration()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeekerRegistration()),
                );
              }
            },
            child: Text(
              "Sign-up",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              "assets/images/children_with_bananas_lq.jpg",
            ),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
//            Padding(padding: EdgeInsets.only(bottom: 190.0)),
            Text(
              "ProSeekr",
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "A job portal for blue-collars",
              style: TextStyle(fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(bottom: 14.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: SelectedActor.JobProvider,
                  groupValue: _character,
                  onChanged: (SelectedActor value) {
                    setState(() {
                      _character = value;
                      print(_character);
                    });
                  },
                ),
                Text(
                  "Job Provider",
                  style: new TextStyle(fontSize: 16.0),
                ),
                Radio(
                  value: SelectedActor.JobSeeker,
                  groupValue: _character,
                  onChanged: (SelectedActor value) {
                    setState(() {
                      _character = value;
                      print(_character);
                    });
                  },
                ),
                Text(
                  "Job Seeker",
                  style: new TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 50.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                signIn,
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 50.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                signUp,
              ],
            )
          ],
        ),
      ),
    );
  }
}
