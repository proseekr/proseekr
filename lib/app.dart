import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proseekr/src/controllers/actor_selection_controller.dart';
import 'package:proseekr/src/controllers/language_preferences_controller.dart';
import 'package:proseekr/src/i18n/app_translations_delegate.dart';
import 'package:proseekr/src/i18n/application.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/language_preferences_view.dart';

var appToRun = LanguagePreferences();

// TODO: Change the context, when the app is resumed from background
void checkPreferences() {
  print("Looking for preferred langauge..."); //TODO: Remove logs
  if (LanguagePreferencesController.isPrefLangSet() &&
      ActorSelectorController.getActor() != globals.SelectedActor.None) {
    print(
        'Found preferred language, navigating to homescreen'); //TODO: Remove logs
//    appToRun = ActorSelector();
  } else {
    print(
        'Didn\'t find preferred languauge, capture preferred languauge from the user.'); //TODO: Remove logs
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
//    checkPreferences();
    print("Building application..."); //TODO: Remove logs
    return MaterialApp(
      title: 'ProSeekr',
      debugShowCheckedModeBanner: false,
      home: appToRun,
      localizationsDelegates: [
        _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
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
