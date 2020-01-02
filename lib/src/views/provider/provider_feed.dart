import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:proseekr/src/controllers/tts_controller.dart';
import 'package:proseekr/src/models/globals.dart' as globals;

import 'HamDraw.dart';
import 'approvedList.dart';
import 'jobParticularApplicants.dart';

//enum ConfirmAction { CANCEL, ACCEPT }
class ProviderFeed extends StatefulWidget {
//  ProviderFeed({Key Key, this.user, this.title}) : super(key: Key);
//  final String title;

  @override
  _ProviderFeedState createState() => _ProviderFeedState();
}

class _ProviderFeedState extends State<ProviderFeed> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String user = globals.userId;
  TextStyle style = TextStyle(fontSize: 15.0, color: Colors.white);
  bool fetchedData = false;
  DocumentSnapshot provider;
  static CollectionReference ref;
  static List<DocumentSnapshot> data = new List<DocumentSnapshot>();
  List<dynamic> jobs = new List<dynamic>();
  static Query q = ref;
  bool confirm = false;
  QuerySnapshot querySnapshot;
  final String title = "ProSeekr";
  DateTime updatedEndDate;
  final TextEditingController _endDateFilter = new TextEditingController();

  @override
  void initState() {
    print("init called" + user);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("#onMessage: $message");
        print("message showed");
        globals.newMessage = true;
        print("message showed");
        //  Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomePage()),
        //     );
        //_showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        globals.newMessage = true;
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage()),
//        );
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        globals.newMessage = true;
        AlertDialog(content: Text("onResume: $message"));
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage()),
//        );
        //_navigateToItemDetail(message);
      },
    );
    super.initState();
    _getData();
  }

  void _getJobs() async {
    var userId = user;
    print(userId);
    provider =
        await Firestore.instance.collection("Provider").document(userId).get();
    print("docID " + provider.documentID);
    ref = Firestore.instance.collection("Jobs");
  }

//  void _getData() async {
//    await _getJobs();
//    jobs = provider.data["Jobs"];
//    print("provider jobs" + jobs.toString());
//    print("jobs initstate");
//    q = Firestore.instance.collection("Jobs");
//    QuerySnapshot querySnapshot = await q.getDocuments();
//
//    data = querySnapshot.documents;
//    print("total jobs" + data.length.toString());
//    if (jobs.length == 0) {
//      data = new List<DocumentSnapshot>();
//    }
//    for (var i = 0; i < jobs.length; i++) {
//      print(jobs[i]);
//
//      if (data[i].documentID != jobs[i]) {
//        data.removeAt(i);
//      }
//    }
//
//    print(data.length);
//    setState(() {});
//  }
  void _getData() async {
    await _getJobs();
    jobs = provider.data["Jobs"];
    data = new List();
    for (var i = 0; i < jobs.length; i++) {
      var doc = await Firestore.instance
          .collection('Jobs')
          .document(jobs.elementAt(i).toString())
          .get();
//      print(doc.documentID);
      data.add(doc);
      print("data" + data[i].documentID);
    }
    if (data != null)
      print(data.length);
    else
      print('Empty data');
    setState(() {});
  }

  void dispose() {
    _endDateFilter.dispose();
    super.dispose();
  }

  _showDateTimePicker() async {
    updatedEndDate = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );
    setState(() {
      print(updatedEndDate);
    });
  }

  _updateDateHelper(String docID, int index) async {
    await ref.document(docID).updateData({
      'period': {
        'start_date': data[index]["period"]["start_date"],
        'end_date': (updatedEndDate.toString().split(" "))[0]
      }
    });
  }

  _updateDate(String docID, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select new End-Date',
                style: TextStyle(color: Colors.black)),
            content: InkWell(
              onTap: () {
                _showDateTimePicker();
              },
              child: IgnorePointer(
                child: new TextFormField(
                  controller: _endDateFilter,
                  decoration: InputDecoration(
                      prefixIcon: new Icon(Icons.date_range),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Application End-Date",
                      labelText: updatedEndDate == null
                          ? "Application End-Date"
                          : (updatedEndDate.toString().split(" "))[0],
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('ACCEPT'),
                onPressed: () {
                  _updateDateHelper(docID, index);
                  setState(() {
                    data[index]["period"]["end_date"] =
                        (updatedEndDate.toString().split(" "))[0];
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Job?'),
          content: const Text('Are you sure you want to delete this job?'),
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

  Future<void> rejectJob(String jobId, int index) async {
    await _asyncConfirmDialog(context);
    if (confirm) {
      setState(() {
        data = List.from(data)..removeAt(index);
      });
      print("deleting job" + jobId);
//      List<dynamic> applicants =  data[index]["applicants"];
//      for(var i=0;i < applicants.length; i++) {
//        await Firestore.instance.collection('Seeker').document(applicants[i])
//          ..updateData({
//            "approved": FieldValue.arrayRemove([data[index].documentID]),
//          });
//      }
      await Firestore.instance
          .collection("Provider")
          .document(user)
          .updateData({
        "Jobs": FieldValue.arrayRemove([jobId]),
      });
      return ref.document(jobId).delete();
    } else
      return null;
  }

  static CollectionReference ref1 = Firestore.instance.collection("Seeker");
  Query q1 = ref1;
  QuerySnapshot querySnapshot1;
  List<DocumentSnapshot> data1;
  List<DocumentSnapshot> filteredData = new List<DocumentSnapshot>();

  Future<void> _getUserData(List applicant) async {
    querySnapshot1 = await q1.getDocuments();
    data1 = await querySnapshot1.documents;
    filteredData = new List<DocumentSnapshot>();
    print(applicant.toString());
    for (var i = 0; i < data1.length; i++) {
      if (applicant.contains(data1[i].documentID)) {
        print("Adding to applicants list");
        filteredData.add(data1[i]);
      }
    }
    print(filteredData.length);
    print("filter" + filteredData[0].data.toString());
  }

  static CollectionReference ref2 = Firestore.instance.collection("Seeker");
  Query q2 = ref2;
  QuerySnapshot querySnapshot2;
  List<DocumentSnapshot> data2;
  List<DocumentSnapshot> approvedData = new List<DocumentSnapshot>();
  Future<void> _getApprovedUserData(List approved) async {
    querySnapshot2 = await q2.getDocuments();
    data2 = await querySnapshot2.documents;
    approvedData = new List<DocumentSnapshot>();
    print(approved.toString());
    for (var i = 0; i < data2.length; i++) {
      if (approved.contains(data2[i].documentID)) {
        print("herehere");
        approvedData.add(data2[i]);
      }
    }
    print(approvedData.length);
    print("filter" + approvedData[0].data.toString());
  }

  String formatString(int index) {
    return data[index]["title"] +
        ". Number of applicants: " +
        data[index]["applicants"].length.toString() +
        ".Job Location:" +
        data[index]["location"] +
        ".Description: " +
        data[index]["description"]["short"] +
        ".Experience: " +
        data[index]["yoe"] +
        "years.Application End-Date:" +
        data[index]["period"]["end_date"];
  }

  @override
  Widget build(BuildContext context) {
    () async {
      await _getData();
    };
    if (data.length == 0) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Your Jobs"),
            backgroundColor: Colors.black,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderFeed()));
                  }),
            ],
          ),
          backgroundColor: Colors.white,
          drawer: HamDraw(),
          body: Center(child: Text('Please upload jobs to continue')));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text("Your Jobs"),
            backgroundColor: Colors.black,
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderFeed()));
                  }),
            ],
          ),
          backgroundColor: Colors.grey[150],
          drawer: HamDraw(),
          body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
//          print('${data[index].data}');
//            if (data == null) return new Text('Loading...');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
//                            ListTile(
//                              title: Text(data[index]['title'],
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,fontSize: 18.0, color: Colors.black)),
////                              title: Text(user)
//                            ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "Experience :" +
                                      " " +
                                      data[index]["yoe"].toString() +
                                      " Years",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "\$ :" +
                                      " " +
                                      data[index]["salary"].toString() +
                                      "/hr ",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  "No.of applicants :" +
                                      " " +
                                      data[index]["applicants"]
                                          .length
                                          .toString() +
                                      "",
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.black),
                                ),
                              ),
                            ]),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text(
                                    "PostedOn :" +
                                        " " +
                                        data[index]["postedOn"],
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ButtonBar(
                                    children: <Widget>[
                                      RaisedButton(
                                        disabledColor: Colors.grey,
                                        color:
                                            data[index]["applicants"].length > 0
                                                ? Colors.black
                                                : Colors.grey,
                                        child: Text(
                                          "List of Applicants",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          print('button pressed');
                                          if (data[index]["applicants"]
                                                  .length !=
                                              0) {
                                            await _getUserData(
                                                data[index]["applicants"]);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApplicantList(
                                                          applicant:
                                                              filteredData,
                                                          jobID: data[index]
                                                              .documentID,
                                                        )));
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ExpansionTile(
                              title: Text("Detail"),
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.description,
                                          color: Colors.black),
                                      title: Text(
                                        "Details",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        data[index]["description"]["detailed"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 11.0),
                                Row(
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          data[index]["location"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]),
                                    Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          data[index]["category"].toString(),
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                SizedBox(height: 11.0),
                                Row(
                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                          "Start Date :" +
                                              " " +
                                              data[index]["period"]
                                                  ["start_date"],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ]),
                                    Column(children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              "End Date :" +
                                                  " " +
                                                  data[index]["period"]
                                                      ["end_date"],
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          new IconButton(
                                            icon: new Icon(Icons.edit),
                                            color: Colors.black,
                                            onPressed: () {
                                              _updateDate(
                                                  data[index]
                                                      .documentID
                                                      .toString(),
                                                  index);
                                            },
                                          ),
                                        ],
                                      ),
                                    ]),
                                  ],
                                ),
                                ButtonBar(
                                  children: <Widget>[
                                    RaisedButton(
                                        color: Colors.black,
                                        child: Text(
                                          "Delete Job",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          rejectJob(
                                              data[index].documentID.toString(),
                                              index);
                                        }),
                                    RaisedButton(
                                        color:
                                            data[index]["approved"].length > 0
                                                ? Colors.black
                                                : Colors.grey,
                                        child: Text(
                                          "Approved List",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          if (data[index]["approved"].length !=
                                              0) {
                                            await _getApprovedUserData(
                                                data[index]["approved"]);
                                            print("approved list pressed" +
                                                approvedData.length.toString());
//                                            approveList(data[index].documentID.toString(), index);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApprovedList(
                                                          Approved:
                                                              approvedData,
                                                          jobID: data[index]
                                                              .documentID,
                                                        )));
                                          }
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
}
