import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proseekr/src/resources/languagePreferencesController.dart';
import 'actorSelector.dart';

class LanguagePreferences extends StatefulWidget {
  LanguagePreferences({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LanguagePreferencesState createState() => _LanguagePreferencesState();
}

class _LanguagePreferencesState extends State<LanguagePreferences> {
  final List<String> _availableLanguages =
      LanguagePreferencesController.getAvailableLanguages();

  String _preferredLangState;

  @override
  void initState() {
    print('In initState of HomePage');
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      _moveToTestRouter();
    });
  }

  void _moveToTestRouter() {
    _preferredLangState = LanguagePreferencesController.getPrefLang();
    if (_preferredLangState == null) {
      print("If-initState");
      LanguagePreferencesController.initLang();
    } else {
      print("else-initState");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ActorSelector()));
    }
  }

  Future<void> _updatePrefLangState(String prefLang) async {
    String lastLanguage = LanguagePreferencesController.getPrefLang();
    LanguagePreferencesController.setPrefLang(prefLang);

    print('c: $prefLang, l: $lastLanguage');

    if (prefLang == lastLanguage) {
      setState(() {
        return _preferredLangState = '$prefLang is selected lang';
      });

      print('In if-block');
      //  await LanguagePreferences.resetLanguage();
    } else {
      setState(() {
        return _preferredLangState = '$prefLang is now your default lang';
      });

      print('In else-block');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Call to Build of HomePage');
    if (mounted == true) {
      print("Home page mounted");
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/children_with_bananas_lq.jpg',
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
            Text(
              'ProSeekr',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'A job portal for blue-collars',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'Select your language',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              _preferredLangState == null
                  ? 'English is the default language'
                  : '$_preferredLangState',
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
                            ? Colors.grey[900]
                            : Colors.grey[800],
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 24),
                          title: Text(
                            _availableLanguages[index],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          onTap: () {
                            _updatePrefLangState(_availableLanguages[index]);
                          },
                        ));
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActorSelector()),
        ),
      ),
    );
  }
}
