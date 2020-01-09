import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/language_preferences_controller.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/i18n/application.dart';
import 'package:proseekr/src/views/actor_selection_view.dart';
import 'package:proseekr/src/widgets/app_description.dart';
import 'package:proseekr/src/widgets/app_title.dart';
import 'package:proseekr/src/widgets/hero_image.dart';

class LanguagePreferences extends StatefulWidget {
  LanguagePreferences({Key key}) : super(key: key);

  @override
  _LanguagePreferencesState createState() => _LanguagePreferencesState();
}

class _LanguagePreferencesState extends State<LanguagePreferences> {
  static final List<String> languagesList = application.supportedLanguages;
  static final List<String> languageCodesList =
      application.supportedLanguagesCodes;

  final Map<dynamic, dynamic> languagesMap = {
    languagesList[0]: languageCodesList[0],
    languagesList[1]: languageCodesList[1],
  };

  final List<String> _availableLanguages =
      LanguagePreferencesController.getAvailableLanguages();

  String _preferredLangState, _lastChosenLanguage;

  @override
  void initState() {
    helper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Building LanguagePreferences context...'); //TODO: Remove logs
    if (mounted == true) {
      print(
          "LangaugePreferences::BuildContext is assinged to CreateState() and attached to widget tree."); //TODO: Remove logs
      _lastChosenLanguage =
          _preferredLangState == null ? 'English' : _preferredLangState;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            HeroImage(),
            SizedBox(height: 24),
            AppTitle(),
            AppDescription(),
            SizedBox(height: 24.0),
            Text(
              AppTranslations.of(context).text("select_your_language"),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8.0),
            Text(
              _preferredLangState ?? '',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _availableLanguages.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 0,
                        shape: ContinuousRectangleBorder(),
                        margin: EdgeInsets.all(0),
                        color: index % 2 == 0
                            ? Colors.black87
                            : Color.fromRGBO(65, 65, 65, 1),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _availableLanguages[index],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          onTap: () {
                            application.onLocaleChanged(
                                Locale(languagesMap[languagesList[index]]));
                            _updatePrefLangState(_availableLanguages[index]);
                          },
                        ));
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActorSelector()),
        ),
      ),
    );
  }

  void helper() {
    print('Initializing LanguagePreferrences class...'); //TODO: Remove logs
//    _preferredLangState = LanguagePreferencesController.getPrefLang();
    print(
        "$_preferredLangState has been set as preferred languauge."); //TODO: Remove logs
//    if (_preferredLangState == null)
//      _preferredLangState = 'English is the default lang';
  }

  void _updatePrefLangState(String prefLang) async {
    _lastChosenLanguage = LanguagePreferencesController.getPrefLang();
    await LanguagePreferencesController.setPrefLang(prefLang);
    print('c: $prefLang, l: $_lastChosenLanguage'); //TODO: Remove logs

    // TODO: Don't show the selected language as the In-App feature is taking care-of
//    if (prefLang == _lastChosenLanguage) {
//      setState(() {
//        _preferredLangState = '$prefLang is selected lang';
//      });
//      print('In if-block'); //TODO: Remove logs
//    } else {
//      setState(() {
//        _preferredLangState = '$prefLang is now your default lang';
//      });
//      print('In else-block'); //TODO: Remove logs
//    }
  }
}
