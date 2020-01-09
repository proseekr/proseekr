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
    print("Calling isPreflangSet().."); //TODO: Remove logs
    var pl = getPrefLang();
    print("Language retuned by the call: $pl"); //TODO: Remove logs
    return pl != null ? true : false;
  }

  static String getPrefLang() {
    print("Calling getPrefLang()..."); //TODO: Remove logs
    _getLanguage();
    print("Called getPrefLang()"); //TODO: Remove logs
    return _preferredLang;
  }

  static void _getLanguage() async {
    print("calling _getLanguage()..."); //TODO: Remove logs
    final prefs = await SharedPreferences.getInstance();
    print("Called _getLanguage()"); //TODO: Remove logs
    _preferredLang = prefs.getString('preferredLang');
    print('CPL: $_preferredLang'); //TODO: Remove logs
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
