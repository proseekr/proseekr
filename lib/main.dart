import 'package:flutter/material.dart';

void main() => runApp(ProSeekerApp());

class ProSeekerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProSeekr',
      debugShowCheckedModeBanner: false,
      home: psHomePage(title: 'Home Page'),
    );
  }
}

class psHomePage extends StatefulWidget {
  psHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _psHomePageState createState() => _psHomePageState();
}

class _psHomePageState extends State<psHomePage> {

  final List<String> _availableLanguages = ['English', 'हिन्दी', 'తెలుగు'];

  var preferredLang = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/children_with_bananas.jpg',
            ),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
            Text(
              'ProSeekr',
              style: TextStyle(fontSize: 48),
            ),
            Text(
              'A job portal for blue-collars',
              style: TextStyle(fontSize: 18),
            ),
            Padding(padding: EdgeInsets.only(bottom: 24.0)),
            Text(
              'Select your language',
              style: TextStyle(fontSize: 24),
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
                            ? Colors.amber[500]
                            : Colors.amber[400],
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 24),
                          title: Text(
                            _availableLanguages[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          onTap: () {
                            print(preferredLang);
                            preferredLang = _availableLanguages[index];
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
