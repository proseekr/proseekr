import 'package:shared_preferences/shared_preferences.dart';

class ProviderSPController {
  static SharedPreferences _prefs;

  static Future<SharedPreferences> getSPInstance() async {
    return await SharedPreferences.getInstance();
  }

  ProviderSPController() {
    getSPInstance().then((instance) {
      _prefs = instance;
    });
  }

  bool isSetUserId() {
    return _prefs.containsKey("userID");
  }

  Future<String> getUserId() async {
    return _prefs.get("userID");
  }

  Future<String> setUserId(String userID) async {
    if(isSetUserId()) {
      await _prefs.setString("userID", userID);
      return getUserId();
  } else {
      return getUserId();
    }
  }
}