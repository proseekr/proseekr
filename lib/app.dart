import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proseekr/src/controllers/actorSelectorController.dart';
import 'package:proseekr/src/controllers/languagePreferencesController.dart';
import 'package:proseekr/src/controllers/routerTestPage.dart';
import 'package:proseekr/src/i18n/app_translations_delegate.dart';
import 'package:proseekr/src/i18n/application.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/languagePreferences.dart';

var appToRun;

void checkPreferences() {
  print("Looking for preferred langauge...");
  if (LanguagePreferencesController.isPrefLangSet() &&
      ActorSelectorController.getActor() != globals.SelectedActor.None) {
    print('Found preferred language, navigating to homescreen');
    appToRun = RouterTestPage();
  } else {
    print(
        'Didn\'t found preferred languauge, capture preferred languauge from the user.');
    appToRun = LanguagePreferences();
  }
}

class ProSeekerApp extends StatefulWidget {
  @override
  _ProSeekerAppState createState() => _ProSeekerAppState();
}

class _ProSeekerAppState extends State<ProSeekerApp> {
  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    checkPreferences();
    print("Building application...");
    return MaterialApp(
      title: 'ProSeekr',
      debugShowCheckedModeBanner: false,
      home: appToRun,
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", ""),
        const Locale("hi", ""),
        const Locale("te", ""),
      ],
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}
