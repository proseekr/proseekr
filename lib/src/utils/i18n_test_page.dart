import 'package:flutter/material.dart';
import 'package:proseekr/src/i18n/app_translations.dart';

class TestPage extends StatelessWidget {
  final List<String> strings = [
    "app_title",
    "app_description",
    "select_your_language",
    "job_provider",
    "job_seeker",
    "login",
    "register",
    "first_name",
    "last_name",
    "email",
    "contact",
    "gender",
    "male",
    "female",
    "others",
    "store_name",
    "address_line",
    "city",
    "state",
    "pin_code",
    "qualification",
    "category",
    "expertise",
    "experience",
    "description",
    "salary",
    "work_hours",
    "posted_on",
    "details",
    "location",
    "ends_on",
    "apply",
    "withdraw",
    "search_jobs",
    "continue",
    "cancel",
    "all_fields_are_required"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView.builder(
          itemCount: strings.length,
          itemBuilder: (context, index) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    strings[index] +
                        ": " +
                        AppTranslations.of(context).text(strings[index]),
                    style: TextStyle(fontSize: 16),
                  ),
                ]);
          }),
    ));
  }
}
