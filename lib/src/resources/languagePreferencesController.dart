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

  static String getPrefLang() {
    _getLanguage();
    return _preferredLang;
  }

  static void initLang() async {
    _preferredLang = await _getLanguage();
    print(_preferredLang);
    _preferredLang = _preferredLang == null ? 'English' : null;
  }

  static Future<String> _getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _preferredLang = prefs.getString('preferredLang');
    print('CPL: $_preferredLang');
    return _preferredLang == null ? 'English' : _preferredLang;
  }

  static Future<void> setPrefLang(String prefLang) async {
    final prefs = await SharedPreferences.getInstance();
    _preferredLang = prefLang;
    await prefs.setString('preferredLang', _preferredLang);
  }

  static Future<void> resetLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredLang', 'English');
  }
}
