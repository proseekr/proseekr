import "package:flutter/material.dart";
import 'package:proseekr/src/controllers/actorSelectorController.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/job_provider/userLogin.dart';
import 'package:proseekr/src/views/job_provider/userRegistration.dart';
import 'package:proseekr/src/views/job_seeker/seekerRegistration.dart';

class ActorSelector extends StatefulWidget {
  ActorSelector({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ActorSelectorState createState() => _ActorSelectorState();
}

class _ActorSelectorState extends State<ActorSelector> {
  globals.SelectedActor _actor = globals.SelectedActor.JobProvider;

  Widget build(BuildContext context) {
    var actor = ActorSelectorController.getActor();
    print("Build: $actor");

    final heroImage =
        Image.asset("assets/images/workers_at_construction_site_lq.jpg");
    final appTitle = Text("app_title", style: TextStyle(fontSize: 48.0));
    final appDescription =
        Text("app_description", style: TextStyle(fontSize: 18.0));
    final signInBtn = materialButtonBuilder(context, "login", signIn);
    final signUpBtn = materialButtonBuilder(context, "register", signUp);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            heroImage,
            SizedBox(height: 24.0),
            appTitle,
            appDescription,
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                radioButtonBuilder(globals.SelectedActor.JobProvider),
                Text("job_provider", style: new TextStyle(fontSize: 16.0)),
                radioButtonBuilder(globals.SelectedActor.JobSeeker),
                Text("job_seeker", style: new TextStyle(fontSize: 16.0)),
              ],
            ),
            SizedBox(height: 40.0),
            signInBtn,
            SizedBox(height: 32.0),
            signUpBtn
          ],
        ),
      ),
    );
  }

  // Widget Builders

  Widget materialButtonBuilder(BuildContext context, String label, var action) {
    return Material(
        color: Colors.black,
        elevation: 5.0,
        borderRadius: BorderRadius.circular(2.0),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width - 80,
            onPressed: action,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )));
  }

  Widget radioButtonBuilder(globals.SelectedActor actor) {
    return Radio(
      activeColor: Colors.black,
      value: actor,
      groupValue: _actor,
      onChanged: (globals.SelectedActor value) {
        setState(() {
          _actor = value;
          print("RadioButtouBuilder: $_actor");
        });
      },
    );
  }

  // Helper Functions

  void signIn() async {
    await ActorSelectorController.setActor(_actor).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserLogin()),
      );
    });
  }

  void signUp() async {
    if (_actor == globals.SelectedActor.JobProvider) {
      await ActorSelectorController.setActor(_actor).then((value) {
        print("calling User reg...");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserRegistration()),
        );
      });
    } else {
      // TODO: Change the route particular to actor
      await ActorSelectorController.setActor(_actor).then((value) {
        print("calling Seeker reg...");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SeekerRegistration()),
        );
      });
    }
  }
}
