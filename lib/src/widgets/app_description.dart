import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';

class AppDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppTranslations.of(context).text("app_description"),
      style: TextStyle(fontSize: 18),
    );
  }
}
