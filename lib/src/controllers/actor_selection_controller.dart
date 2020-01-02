import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class ActorSelectorController {
  static String _actor;

  static globals.SelectedActor getActor() {
    print("Calling getActor()...");
    _getActor();
    print("Called _getActor()");
    if (_actor == "provider") {
      return globals.SelectedActor.JobProvider;
    } else if (_actor == "seeker") {
      return globals.SelectedActor.JobSeeker;
    } else {
      return globals.SelectedActor.None;
    }
  }

  static void _getActor() async {
    print("Calling _getActor()...");
    var prefs = await SharedPreferences.getInstance();
    _actor = prefs.getString("actor");
    print("_getActor(): $_actor");
  }

  static Future<void> setActor(globals.SelectedActor actor) async {
    print("Calling setActor()...");
    var prefs = await SharedPreferences.getInstance();
    if (actor == globals.SelectedActor.JobSeeker) {
      await prefs.setString("actor", "seeker");
    } else {
      await prefs.setString("actor", "provider");
    }
  }
}
