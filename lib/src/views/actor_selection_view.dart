import "package:flutter/material.dart";
import 'package:proseekr/src/controllers/actor_selection_controller.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/provider/provider_reg_view.dart';
import 'package:proseekr/src/views/seeker/seeker_reg_view.dart';
import 'package:proseekr/src/views/user_login_view.dart';
import 'package:proseekr/src/widgets/app_description.dart';
import 'package:proseekr/src/widgets/app_title.dart';
import 'package:proseekr/src/widgets/hero_image.dart';

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
    print("Build: $actor"); // TODO: Remove logs

    final signInBtn = materialButtonBuilder(context, "login", signIn);
    final signUpBtn = materialButtonBuilder(context, "register", signUp);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            HeroImage(),
            SizedBox(height: 24.0),
            AppTitle(),
            AppDescription(),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                radioButtonBuilder(globals.SelectedActor.JobProvider),
                Text(AppTranslations.of(context).text("job_provider"),
                    style: TextStyle(fontSize: 16.0)),
                radioButtonBuilder(globals.SelectedActor.JobSeeker),
                Text(AppTranslations.of(context).text("job_seeker"),
                    style: TextStyle(fontSize: 16.0)),
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
              AppTranslations.of(context).text(label),
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
          print("RadioButtouBuilder: $_actor"); // TODO: Remove logs
        });
      },
    );
  }

  // Helper Functions

  void signIn() async {
    var actor = "None";
    await ActorSelectorController.setActor(_actor).then((value) {
      if (_actor == globals.SelectedActor.JobProvider) {
        actor = "JobProvider";
      } else {
        actor = "JobSeeker";
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserLogin(actor)),
      );
    });
  }

  void signUp() async {
    if (_actor == globals.SelectedActor.JobProvider) {
      print("calling User reg..."); // TODO: Remove logs
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserRegistration()),
      );
    } else {
      print("calling Seeker reg..."); // TODO: Remove logs
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SeekerRegistration()),
      );
    }
  }
}
