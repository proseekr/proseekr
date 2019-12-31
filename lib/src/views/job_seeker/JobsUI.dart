import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/TTs.dart';
import 'package:proseekr/src/i18n/app_translations.dart';

class JobsUI extends StatelessWidget {
  List<DocumentSnapshot> data;
  String user;
  String searchKey;
  Function appliedforJobs;
  Function FavIconChange;

  JobsUI(this.data, this.user, this.searchKey, this.appliedforJobs,
      this.FavIconChange);

  String formatString(BuildContext context, int index) {
    return data[index]["title"] +
        "." +
        AppTranslations.of(context).text("Job Location") +
        ":" +
        data[index]["location"] +
        "." +
        AppTranslations.of(context).text("Description") +
        ": " +
        data[index]["description"]["short"] +
        "." +
        AppTranslations.of(context).text("Experience") +
        ": " +
        data[index]["yoe"] +
        AppTranslations.of(context).text("Years") +
        AppTranslations.of(context).text("Application End-Date") +
        data[index]["period"]["end_date"];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(data[index]["title"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Tts(formatString(context, index)),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.favorite,
                                      color: data[index]["favourite"]
                                              .contains(user)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onTap: () {
                                      print("on tpprf vsllrf");
                                      FavIconChange(
                                          data[index].documentID, index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(data[index]["description"]["short"],
                            style: TextStyle(color: Colors.black)),
                      ),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                              AppTranslations.of(context).text("Experience") +
                                  " : " +
                                  data[index]["yoe"].toString() +
                                  " " +
                                  AppTranslations.of(context).text("Years"),
                              style: TextStyle(color: Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("\₹" + data[index]["salary"].toString(),
                              style: TextStyle(color: Colors.black)),
                        ),
                      ]),
                      Row(children: <Widget>[]),
                      ExpansionTile(
//                    title:  new Text("abc")
                        title: Row(
//                          mainAxisAlignment: MainAxisAlignment
//                              .spaceAround, //TODO expansion tile downarrow for card
//                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            AutoSizeText(
                                AppTranslations.of(context)
                                        .text("Application End-Date") +
                                    ":" +
                                    data[index]["period"]["end_date"]
                                        .toString(),
                                style: TextStyle(color: Colors.black)),
//                            Icon(Icons.arrow_downward, color: Colors.black)
                          ],
                        ),
                        children: <Widget>[
                          ListTile(
                            leading:
                                Icon(Icons.description, color: Colors.black),
                            title: AutoSizeText(
                                AppTranslations.of(context).text("Details"),
                                style: TextStyle(color: Colors.black)),
                          ),
                          ListTile(
                            title: AutoSizeText(
                                data[index]["description"]["detailed"]
                                    .toString(),
                                style: TextStyle(color: Colors.black)),
                          ),
                          Row(
                            children: <Widget>[
                              Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                      AppTranslations.of(context)
                                          .text("Location"),
                                      style: TextStyle(color: Colors.black)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(data[index]["location"],
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ]),
                              Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                      AppTranslations.of(context)
                                          .text("Category"),
                                      style: TextStyle(color: Colors.black)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      data[index]["category"].toString(),
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ]),
                            ],
                          ),
                          ButtonBar(
                            children: <Widget>[
                              data[index]["approved"].contains(user)
                                  ? Text(
                                      AppTranslations.of(context)
                                          .text("Application Approved"),
                                      style: TextStyle(color: Colors.black),
                                    )
                                  : RaisedButton(
                                      child: data[index]["applicants"]
                                              .contains(user)
                                          ? Text(
                                              AppTranslations.of(context)
                                                  .text("Withdraw Application"),
                                              style: TextStyle(
                                                  color: Colors.black))
                                          : Text(
                                              AppTranslations.of(context)
                                                  .text("Apply Now"),
                                              style: TextStyle(
                                                  color: Colors.black)),
                                      onPressed: () => appliedforJobs(
                                          data[index].documentID, index),
                                    )
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ]),
          );
        });
  }
}
