import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("ProSeekr"),
          backgroundColor: Colors.grey[850],
        ),
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
                      ListTile(
                        title: Text(widget.applicant[index]["basic_details"]
                                ["first_name"] +
                            " " +
                            widget.applicant[index]["basic_details"]
                                ["last_name"]),
                      ),
                      Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Email :" +
                              widget.applicant[index]["basic_details"]
                                  ["email"]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("\$ :" +
                              widget.applicant[index]["basic_details"]
                                      ["contact"]
                                  .toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Gender :" +
                              widget.applicant[index]["basic_details"]
                                  ["gender"]),
                        ),
                      ]),
                      ExpansionTile(
                        title: Text("Expansion Title 1"),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.description),
                            title: Text("Basic Qualification"),
                          ),
                          ListTile(
                            title: Text(
                                widget.applicant[index]["basic_qualification"]),
                          ),
                          Row(
                            children: <Widget>[
                              Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      widget.applicant[index]["address"]
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                              Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Category",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                      widget.applicant[index]["category"]
                                          .toString(),
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ]),
                              Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "Experience",
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
                            ],
                          ),
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
