import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/languagePreferencesController.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/i18n/application.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(AppTranslations.of(context).text("Settings"),
            style: TextStyle(color: Colors.white)),
        elevation: 8.0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  AppTranslations.of(context).text("Language Preferences")),
              leading: Icon(Icons.translate),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LanguageSettings()));
              },
            );
          },
        ),
      ),
    );
  }
}

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppTranslations.of(context).text("Language Preferences"),
            style: TextStyle(color: Colors.white)),
//        leading: Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppTranslations.of(context).text("select_your_language"),
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
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
                          },
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
