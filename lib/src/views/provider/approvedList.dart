import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/tts_controller.dart';
import 'package:proseekr/src/models/globals.dart' as globals;

import 'HamDraw.dart';

class ApprovedList extends StatefulWidget {
  final String title;
  List<DocumentSnapshot> Approved;
  final String jobID;
  ApprovedList({Key key, this.title, this.Approved, this.jobID})
      : super(key: key);
  @override
  _ApprovedListState createState() => _ApprovedListState();
}

class _ApprovedListState extends State<ApprovedList> {
  String user = globals.userId;
  static CollectionReference ref = Firestore.instance.collection("Seeker");
  bool confirm = false;

  @override
  void initState() {
    print("approved init called");
    print(widget.Approved.length);
    super.initState();
  }

  String formatString(int index) {
    return widget.Approved[index]["basic_details"]["first_name"] +
        widget.Approved[index]["basic_details"]["last_name"] +
        ". Basic qualification: " +
        widget.Approved[index]["basic_qualification"] +
        ".Experience: " +
        widget.Approved[index]["experience"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Approved list"),
          backgroundColor: Colors.black,
        ),
        drawer: HamDraw(),
        body: ListView.builder(
            itemCount: widget.Approved.length,
            itemBuilder: (context, index) {
              print(widget.Approved.length);
              print('Here ${widget.Approved[index].data}');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                                widget.Approved[index]["basic_details"]
                                        ['first_name'] +
                                    " " +
                                    widget.Approved[index]["basic_details"]
                                        ['last_name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  TtsController(formatString(index)),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Gender :" +
                              " " +
                              widget.Approved[index]["basic_details"]
                                  ["gender"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Contact:" +
                              " " +
                              widget.Approved[index]["basic_details"]["contact"]
                                  .toString()),
                        ),
                      ]),
                      ExpansionTile(
                        leading: Icon(Icons.description),
                        title: Text("More details"),
                        children: <Widget>[
                          Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      "Address:" +
                                          " " +
                                          widget.Approved[index]["address"]
                                                  ['address_line']
                                              .toString() +
                                          ",",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      widget.Approved[index]["address"]['city']
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      widget.Approved[index]["address"]['state']
                                              .toString() +
                                          ",",
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      widget.Approved[index]["address"]
                                              ['pincode']
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ]),
                          Row(children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Category:",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                  widget.Approved[index]["category"][0]
                                      .toString(),
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ]),
                          Row(children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Experience:",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Text(
                                  widget.Approved[index]["experience"]
                                      .toString(),
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ]),
                        ],
                      )
                    ],
                  ))
                ]),
              );
            }));
  }
}
