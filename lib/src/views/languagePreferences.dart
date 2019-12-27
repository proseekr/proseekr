import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/languagePreferencesController.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/i18n/application.dart';
import 'package:proseekr/src/views/actorSelector_m.dart';
import 'package:proseekr/src/widgets/app_description.dart';
import 'package:proseekr/src/widgets/app_title.dart';

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
    languagesList[2]: languageCodesList[2],
  };

  final List<String> _availableLanguages =
      LanguagePreferencesController.getAvailableLanguages();

  String _preferredLangState, _lastChosenLanguage;

  void helper() {
    print('Initializing LanguagePreferrences class...');
    _preferredLangState = LanguagePreferencesController.getPrefLang();
    print("$_preferredLangState has been set as preferred languauge.");
    if (_preferredLangState == null)
      _preferredLangState = 'English is the default lang';
  }

  @override
  void initState() {
    helper();
    super.initState();
  }

  void _updatePrefLangState(String prefLang) async {
    _lastChosenLanguage = LanguagePreferencesController.getPrefLang();
    await LanguagePreferencesController.setPrefLang(prefLang);
    print('c: $prefLang, l: $_lastChosenLanguage');

    if (prefLang == _lastChosenLanguage) {
      setState(() {
        _preferredLangState = '$prefLang is selected lang';
      });
      print('In if-block');
    } else {
      setState(() {
        _preferredLangState = '$prefLang is now your default lang';
      });
      print('In else-block');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building LanguagePreferences context...');
    if (mounted == true) {
      print(
          "LangaugePreferences::BuildContext is assinged to CreateState() and attached to widget tree.");
      _lastChosenLanguage =
          _preferredLangState == null ? 'English' : _preferredLangState;
    }
//    if (_preferredLangState != null) {
//      return Scaffold(
//        backgroundColor: Colors.black,
//        body: Center(
//            child: Text(
//          'Test Scaffold',
//          style: TextStyle(color: Colors.white),
//        )),
//      );
//    } else {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/workers_at_construction_site_lq.jpg',
            ),
            SizedBox(
              height: 24.0,
            ),
            AppTitle(),
            AppDescription(),
            SizedBox(
              height: 24.0,
            ),
            Text(
              AppTranslations.of(context).text("select_your_language"),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 8.0,
            ),
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
//  }
}
