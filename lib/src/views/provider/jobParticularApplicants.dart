import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/tts_controller.dart';
import 'package:proseekr/src/models/globals.dart' as globals;

import 'HamDraw.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class ApplicantList extends StatefulWidget {
  final String title;
  List<DocumentSnapshot> applicant;
  final String jobID;
  ApplicantList({Key key, this.title, this.applicant, this.jobID})
      : super(key: key);
  @override
  _ApplicantListState createState() => _ApplicantListState();
}

class _ApplicantListState extends State<ApplicantList> {
  String user = globals.userId;
  static CollectionReference ref = Firestore.instance.collection("Seeker");
//  static List<DocumentSnapshot> data;
////  List<DocumentSnapshot> filteredData = new List<DocumentSnapshot>();
//  List<DocumentSnapshot> filteredData = new List<DocumentSnapshot>();
//  static Query q = ref;
  bool confirm = false;
//  QuerySnapshot querySnapshot;

  @override
  void initState() {
    print("init called");
    print(widget.applicant.length);
    super.initState();
//    _getData();
  }

//  void _getData() async {
//    print("jobs initstate");
//    Query q = ref;
//    QuerySnapshot querySnapshot = await q.getDocuments();
//    data = querySnapshot.documents;
//    for(var i=0;i< data.length; i++){
//      if(widget.applicant.contains(data[i].documentID)){
//        filteredData.add(data[i]);
//      }
//    }
//  }
  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Approve Candidate?'),
          content: const Text('Click on Accept to approve.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                confirm = false;
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                confirm = true;
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> removeFromApplicants(String userId) async {
    print("removing applicant from array");
    await Firestore.instance
        .collection("Jobs")
        .document(widget.jobID)
        .updateData({
      "applicants": FieldValue.arrayRemove([userId]),
      "approved": FieldValue.arrayUnion([userId])
    });
  }

  Future<void> approvedJob(String userId, int index) async {
    await _asyncConfirmDialog(context);
    if (confirm) {
      setState(() {
        print("removing card");
        widget.applicant = List.from(widget.applicant)..removeAt(index);
      });
      await ref.document(userId).updateData({
        "approved": FieldValue.arrayUnion([widget.jobID]),
      });
      removeFromApplicants(userId);
    } else
      return null;
  }

  String formatString(int index) {
    return widget.applicant[index]["basic_details"]["first_name"] +
        widget.applicant[index]["basic_details"]["last_name"] +
        ". Basic qualification: " +
        widget.applicant[index]["basic_qualification"] +
        ".Experience: " +
        widget.applicant[index]["experience"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[150],
        appBar: new AppBar(
          title: new Text("Applicants list"),
          backgroundColor: Colors.black,
        ),
        drawer: HamDraw(),
        body: ListView.builder(
            itemCount: widget.applicant.length,
            itemBuilder: (context, index) {
              print(widget.applicant.length);
              print('Here ${widget.applicant[index].data}');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Card(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
//                          ListTile(
//                            title: Text(widget.applicant[index]["basic_details"]
//                                    ["first_name"] +
//                                " " +
//                                widget.applicant[index]["basic_details"]
//                                    ["last_name"]),
//                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                                widget.applicant[index]["basic_details"]
                                        ['first_name'] +
                                    " " +
                                    widget.applicant[index]["basic_details"]
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
                              widget.applicant[index]["basic_details"]
                                  ["gender"]),
                        ),
//                        Padding(
//                          padding: const EdgeInsets.symmetric(horizontal: 15),
//                          child: Text("Email :" +" "+
//                              widget.applicant[index]["basic_details"]
//                                  ["email"]),
//                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Contact:" +
                              " " +
                              widget.applicant[index]["basic_details"]
                                      ["contact"]
                                  .toString()),
                        ),
                      ]),
                      ExpansionTile(
                        leading: Icon(Icons.description),
                        title: Text("More details"),
                        children: <Widget>[
//                          Row(
//                            children: <Widget>[
//                              Padding(
////                                leading: Icon(Icons.description),
//                                child:  Text("Basic Qualification", style: TextStyle(fontWeight: FontWeight.bold)),
//                              ),
//                              Padding(
//                              child: Text(
//                                    widget.applicant[index]["basic_qualification"],style: TextStyle(
//                                    fontSize: 15.0, color: Colors.black),),
//                              ),
//                            ],
//                          ),

                          Column(children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      "Address:" +
                                          " " +
                                          widget.applicant[index]["address"]
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
                                      widget.applicant[index]["address"]['city']
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      widget.applicant[index]["address"]
                                                  ['state']
                                              .toString() +
                                          ",",
                                      style: TextStyle(fontSize: 15)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                      widget.applicant[index]["address"]
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
                                  widget.applicant[index]["category"][0]
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
                                  widget.applicant[index]["experience"]
                                      .toString(),
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ]),
                          ButtonBar(
                            children: <Widget>[
                              RaisedButton(
                                  child: Text(
                                    "Approve Candidate",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    approvedJob(
                                        widget.applicant[index].documentID
                                            .toString(),
                                        index);
//                                      Navigator.pop(context,index.toString()+" "+ widget.jobID);
                                  })
                            ],
                          )
                        ],
                      )
                    ],
                  ))
                ]),
              );
            }));
  }
}
