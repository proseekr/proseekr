import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Router Test Page",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                child: Text("Go back"),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}
