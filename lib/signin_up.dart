import 'package:flutter/material.dart';
import 'forms.dart';
import 'tempForm.dart';
enum SelectedActor { JobProvider, JobSeeker }
class psSignupin extends StatefulWidget{
  psSignupin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _psSignupinState createState() => _psSignupinState();
}
class _psSignupinState extends State<psSignupin>{

  SelectedActor _character = SelectedActor.JobProvider;
  Widget build(BuildContext context) {
    final Signin = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => signin()),
              );
            },
            child: Text("Sign-in",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
        )
    );
    final Signup = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black,
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              print('signup called');
              if(_character=='Job Provider') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              }
              else{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => signup()),
                );
              }
            },
            child: Text("Sign-up",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
        )
    );
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/children_with_bananas_lq.jpg',
            ),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
//            Padding(padding: EdgeInsets.only(bottom: 190.0)),
            Text(
              'ProSeekr',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'A job portal for blue-collars',
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
                    setState(() { _character = value; print(_character); });
                  },
                ),
                 Text(
                  'Job Provider',
                  style: new TextStyle(fontSize: 16.0),
                ),
                 Radio(
                  value: SelectedActor.JobSeeker,
                  groupValue: _character,
                  onChanged: (SelectedActor value) {
                    setState(() { _character = value; print(_character); });
                  },
                ),
                 Text(
                  'Job Seeker',
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
                Signin,
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 50.0)),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Signup,
              ],
            )
          ],
        ),
      ),
    );
  }
}

