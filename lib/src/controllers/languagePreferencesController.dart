import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferencesController {
  static const List<String> _availableLanguages = [
    'English',
    'हिन्दी',
    'తెలుగు'
  ];

  static var _preferredLang;

  static List<String> getAvailableLanguages() {
    return _availableLanguages;
  }

  static bool isPrefLangSet() {
    print("Calling isPreflangSet()..");
    var pl = getPrefLang();
    print("Language retuned by the call: $pl");
    return pl != null ? true : false;
  }

  static String getPrefLang() {
    print("Calling getPrefLang()...");
    _getLanguage();
    print("Called getPrefLang()");
    return _preferredLang;
  }

  static void _getLanguage() async {
    print("calling _getLanguage()...");
    final prefs = await SharedPreferences.getInstance();
    print("Called _getLanguage()");
    _preferredLang = prefs.getString('preferredLang');
    print('CPL: $_preferredLang');
  }

  static Future<void> setPrefLang(String prefLang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredLang', _preferredLang);
    _preferredLang = prefLang;
  }

  static void resetLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredLang', 'English');
  }
}
