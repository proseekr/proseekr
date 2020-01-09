import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/tts_controller.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/provider/app_drawer_view.dart';

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
  bool confirm = false;

  @override
  void initState() {
    print("init called"); //TODO: Remove logs
    print(widget.applicant.length); //TODO: Remove logs
    super.initState();
  }

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
              child: const Text('Decline'),
              onPressed: () {
                confirm = false;
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('Accept'),
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
    print("Removing applicant from array"); //TODO: Remove logs
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
        print("removing card"); //TODO: Remove logs
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
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: widget.applicant.length,
            itemBuilder: (context, index) {
              print(widget.applicant.length); //TODO: Remove logs
              print('Here ${widget.applicant[index].data}'); //TODO: Remove logs
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
