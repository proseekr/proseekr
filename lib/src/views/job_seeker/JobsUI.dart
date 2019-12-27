import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JobsUI extends StatelessWidget {
  List<DocumentSnapshot> data;
  String user;
  Function appliedForJobs;
  Function favIconChange;

  JobsUI(this.data, this.user, this.appliedForJobs, this.favIconChange);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Card(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    trailing: InkWell(
                      child: Icon(Icons.favorite,
                          color: data[index]["favourite"].contains(user)
                              ? Colors.blue
                              : Colors.grey,
                          size: 35),
                      onTap: () {
                        print("on tpprf vsllrf");
                        favIconChange(data[index].documentID, index);
                      },
                    ),
                    title: Text(data[index]["title"]),
                  ),
                  ListTile(
                    title: Text(data[index]["description"]["short"]),
                  ),
                  Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Experience :" +
                          data[index]["yoe"].toString() +
                          " Years"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "\$ :" + data[index]["salary"].toString() + "/hr "),
                    ),
                  ]),
                  Row(children: <Widget>[]),
                  ExpansionTile(
                    title: Text("tile"),
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.description),
                        title: AutoSizeText("Details"),
                      ),
                      ListTile(
                        title: AutoSizeText(
                            data[index]["description"]["detailed"].toString()),
                      ),
                      Row(
                        children: <Widget>[
                          Column(children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Location",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(data[index]["location"],
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ]),
                          Column(children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Category",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(data[index]["category"],
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ]),
                        ],
                      ),
                      ButtonBar(
                        children: <Widget>[
                          RaisedButton(
                            child: data[index]["applicants"].contains(user)
                                ? Text(
                                    "Remove Application",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    "Apply Now",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                            onPressed: () =>
                                appliedForJobs(data[index].documentID, index),
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
