//import 'package:flutter/material.dart';
//import 'package:keyboard_avoider/keyboard_avoider.dart';
//import 'package:intl/intl.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:proseekr/src/i18n/app_translations.dart';
//import 'package:proseekr/src/models/globals.dart' as globals;
//import 'package:proseekr/src/views/job_provider/provider_feed.dart';
//
//class JobPosting extends StatefulWidget{ //TODO change to radio buttons - changed
//  JobPosting({Key Key, this.title}) : super(key: Key);
//  final String title;
//
//  @override
//  _JobPostingState createState() => _JobPostingState();
//}
//
//class _JobPostingState extends State<JobPosting>{
//  String user = globals.userId;
//  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  TextStyle style = TextStyle( fontSize: 14.0);
//  final TextEditingController _categoryFilter = new TextEditingController();
//  final TextEditingController _jobNameFilter = new TextEditingController();
//  final TextEditingController _salaryFilter = new TextEditingController();
//  final TextEditingController _startDateFilter = new TextEditingController();
//  final TextEditingController _endDateFilter = new TextEditingController();
//  final TextEditingController _locationFilter = new TextEditingController();
//  final TextEditingController _shortDescFilter = new TextEditingController();
//  final TextEditingController _longDescFilter = new TextEditingController();
//  final TextEditingController _yoeFilter = new TextEditingController();
//
//  List<String> _experience = ['0', '1', '2', '3', '4', '5'];
//  List<String> _category = ['Plumbing', 'Carpentry', 'Electrical'];
//  List<bool> _categoryValue = [false, false, false];
//  String _selectedCategory = "";
//
//  bool _autoValidate = false;
//  String _selectedExperience;
//
//  void dispose(){
//    _categoryFilter.dispose();
//    _jobNameFilter.dispose();
//    _salaryFilter.dispose();
//    _startDateFilter.dispose();
//    _endDateFilter.dispose();
//    _locationFilter.dispose();
//    _shortDescFilter.dispose();
//    _longDescFilter.dispose();
//    _yoeFilter.dispose();
//    super.dispose();
//  }
//
//  DateTime startSelected;
//  final format = DateFormat("dd-MM-yyyy");
//  DateTime endSelected;
//  DateTime postedOn = DateTime.now();
//
//  _showDateTimePicker() async {
//    startSelected = await showDatePicker(
//      context: context,
//      initialDate: new DateTime.now(),
//      firstDate: new DateTime(1960),
//      lastDate: new DateTime(2050),
//    );
//
//    setState(() {print(startSelected);});
//  }
//  _showDateTimePicker1() async {
//    endSelected = await showDatePicker(
//      context: context,
//      initialDate: new DateTime.now(),
//      firstDate: new DateTime(1960),
//      lastDate: new DateTime(2050),
//    );
//
//    setState(() {print(endSelected);});
//  }
//  void _showDialog() {
//    // flutter defined function
//    Fluttertoast.showToast(
//        msg: "Please enter all the fields",
//        toastLength: Toast.LENGTH_LONG,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIos: 1,
//        backgroundColor: Colors.black,
//        textColor: Colors.white,
//        fontSize: 16.0
//    );
//  }
//  void pushData() async{
//    String jobId = '';
//  await  Firestore.instance
//        .collection('Jobs')
//        .add({
//      "description": {
//        "short": _shortDescFilter.text,
//        "detailed": _longDescFilter.text,
//      },
//      "period": {
//        "start_date": (startSelected.toString().split(" "))[0],
//        "end_date":   (endSelected.toString().split(" "))[0],
//      },
//      "location":_locationFilter.text,
//      "salary":_salaryFilter.text,
//      "title": _jobNameFilter.text,
//      "category": _selectedCategory,
//      "yoe": _selectedExperience,
//      "provider_id": user,
//      "postedOn": (postedOn.toString().split(" "))[0],
//      "applicants": new List(),
//      "favourite": new List(),
//      "approved": new List()
//    }).then((doc){
//      jobId = doc.documentID;
//  });
//    await Firestore.instance
//        .collection("Provider")
//        .document(user)
//        .updateData({
//      "Jobs": FieldValue.arrayUnion([jobId]),
//    });
//  }
//  Widget buildService(BuildContext context, int index, List list, List value) {
//    String _key = list.elementAt(index);
//
//    return Container(
//      child: Card(
//        elevation: 0,
//        child: CheckboxListTile(
//          controlAffinity: ListTileControlAffinity.leading,
//          dense: true,
//          onChanged: (bool checkedValue) {
//            setState(() {
//              value[index] = !value[index];
//            });
//          },
//          value: value[index],
//          title: Text(_key),
//        ),
//      ),
//    );
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.white,
//        appBar: AppBar(
//          title: Text("Upload Job"),
//        backgroundColor:Colors.black
//        ),
//        body: Container(
//            padding: EdgeInsets.all(20),
//            child: KeyboardAvoider(
//                autoScroll: true,
//                child: Form(
//                    key: _formKey,
//                    autovalidate: _autoValidate,
//                    child: SingleChildScrollView(
//                        child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
////                            crossAxisAlignment: CrossAxisAlignment.end,
//                            children: <Widget>[
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Center(
//                                child: Text(
//                                    "JOB VACANCY DETAILS",
//                                    style:style
//                                ),
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              TextFormField(
//                                obscureText: false,
//                                style: TextStyle(color: Colors.white),
//                                controller: _jobNameFilter,
//                                decoration: InputDecoration(
//                                    filled: true,
//                                    fillColor: Colors.black,
//                                    prefixIcon:
//                                    new Icon(Icons.work, color: Colors.white),
//                                    contentPadding:
//                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                    hintText:
//                                    AppTranslations.of(context).text("job_title"),
//                                    hintStyle: TextStyle(color: Colors.grey),
//                                    enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(style: BorderStyle.none),
//                                        borderRadius: BorderRadius.circular(4.0))),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter the Job name';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              TextFormField(
//                                obscureText: false,
//                                style: TextStyle(color: Colors.white),
//                                controller: _shortDescFilter,
//                                decoration: InputDecoration(
//                                    filled: true,
//                                    fillColor: Colors.black,
//                                    prefixIcon:
//                                    new Icon(Icons.description, color: Colors.white),
//                                    contentPadding:
//                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                    hintText:
//                                    AppTranslations.of(context).text("short_desc"),
//                                    hintStyle: TextStyle(color: Colors.grey),
//                                    enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(style: BorderStyle.none),
//                                        borderRadius: BorderRadius.circular(4.0))),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter a short description';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              TextFormField(
//                                obscureText: false,
//                                style: TextStyle(color:Colors.white),
//                                controller: _longDescFilter,
//                                  decoration: InputDecoration(
//                                      filled: true,
//                                      fillColor: Colors.black,
//                                      prefixIcon:
//                                      new Icon(Icons.description, color: Colors.white),
//                                      contentPadding:
//                                      EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                      hintText:
//                                      AppTranslations.of(context).text("long_desc"),
//                                      hintStyle: TextStyle(color: Colors.grey),
//                                      enabledBorder: OutlineInputBorder(
//                                          borderSide: BorderSide(style: BorderStyle.none),
//                                          borderRadius: BorderRadius.circular(4.0))),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter a long description';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Center(
//                                  child: Text(
//                                      "SELECT PROFICIENCY",
//                                      style: style
//                                  )),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Container(
//                                child: ListView.builder(
//                                    physics: const AlwaysScrollableScrollPhysics(),
//                                    shrinkWrap: true,
//                                    itemCount: _category.length,
//                                    itemBuilder: (BuildContext context, int index) {
//                                      return buildService(
//                                          context, index, _category, _categoryValue);
//                                    }),
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Center(
//                                  child: Text(
//                                      "ADDITIONAL DETAILS",
//                                      style: style
//                                  )),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              TextFormField(
//                                obscureText: false,
//                                style: TextStyle(color: Colors.white),
//                                controller: _salaryFilter,
//                                decoration: InputDecoration(
//                                    filled: true,
//                                    fillColor: Colors.black,
//                                    prefixIcon:
//                                    new Icon(Icons.attach_money, color: Colors.white),
//                                    contentPadding:
//                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                    hintText:
//                                    AppTranslations.of(context).text("salary"),
//                                    hintStyle: TextStyle(color: Colors.grey),
//                                    enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(style: BorderStyle.none),
//                                        borderRadius: BorderRadius.circular(4.0))),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter the salary';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              InkWell(
//                                onTap: () {
//                                  _showDateTimePicker();
//                                },
//                                child: IgnorePointer(
//                                  child: new TextFormField(
//                                    controller: _startDateFilter,
//                                    decoration: InputDecoration(
//                                        filled: true,
//                                        fillColor: Colors.black,
//                                        prefixIcon:new Icon(Icons.date_range, color: Colors.white),
//                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                        hintText: "Application Start-Date",
//                                        labelText: startSelected == null? "Application Start-Date": (startSelected.toString().split(" "))[0],
//                                        labelStyle: TextStyle(
//                                          color: Colors.white,
//                                        ),
//                                        border:
//                                        OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
//                                    onSaved: (String val) {
//
//                                    },
//                                  ),
//                                ),
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              InkWell(
//                                onTap: () {
//                                  _showDateTimePicker1();
//                                },
//                                child: IgnorePointer(
//                                  child: new TextFormField(
//                                    controller: _endDateFilter,
//                                    decoration: InputDecoration(
//                                        filled: true,
//                                        fillColor: Colors.black,
//                                        prefixIcon:new Icon(Icons.date_range, color: Colors.white),
//                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                        hintText: "Application End-Date",
//                                        labelText: endSelected == null? "Application End-Date" : (endSelected.toString().split(" "))[0],
//                                        labelStyle: TextStyle(
//                                          color: Colors.white,
//                                        ),
//                                        border:
//                                        OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
////                                    maxLength: 10,
////                                    validator: (value) {
////                                      if (value.isEmpty) {
////                                        return 'Please enter some text';
////                                      }
////                                      return null;
////                                    },
//                                    onSaved: (String val) {
//
//                                    },
//                                  ),
//                                ),
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              TextFormField(
//                                obscureText: false,
//                                style: TextStyle(color: Colors.white),
//                                controller: _locationFilter,
//                                decoration: InputDecoration(
//                                    filled: true,
//                                    fillColor: Colors.black,
//                                    prefixIcon:
//                                    new Icon(Icons.location_on, color: Colors.white),
//                                    contentPadding:
//                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                    hintText:
//                                    AppTranslations.of(context).text("location"),
//                                    hintStyle: TextStyle(color: Colors.grey),
//                                    enabledBorder: OutlineInputBorder(
//                                        borderSide: BorderSide(style: BorderStyle.none),
//                                        borderRadius: BorderRadius.circular(4.0))),
//                                validator: (value) {
//                                  if (value.isEmpty) {
//                                    return 'Please enter the location';
//                                  }
//                                  return null;
//                                },
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Container(
//                                padding: EdgeInsets.symmetric(horizontal: 10.0),
//                                decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(4.0),
//                                  border: Border.all(
//                                      color: Colors.black, style: BorderStyle.solid, width: 0.0),
//                                ),
//                                child: DropdownButton(
//                                  elevation: 0,
//                                  underline: Container(
//                                    height: 0,
//                                  ),
//                                  hint: Text('Experience(yrs)'), // Not necessary for Option 1
//                                  value: _selectedExperience,
//                                  onChanged: (newValue) {
//                                    setState(() {
//                                      _selectedExperience = newValue;
//                                    });
//                                  },
//                                  items: _experience.map((experience) {
//                                    return DropdownMenuItem(
//                                      child: new Text(experience),
//                                      value: experience,
//                                    );
//                                  }).toList(),
//                                ),
//                              ),
//                              Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03)),
//                              Material(
//                                elevation: 0.0,
//                                borderRadius: BorderRadius.circular(30.0),
//                                color: Colors.black,
//                                child: MaterialButton(
//                                  minWidth: MediaQuery.of(context).size.width*0.3,
//                                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//
//                                  onPressed: () async{
//                                    if(_formKey.currentState.validate()){
//                                     await pushData();
//                                      Navigator.push(
//                                        context,
//                                MaterialPageRoute(builder: (context) => ProviderFeed()),
//                                      );
//                                    }
//                                    else {
//                                      _showDialog();
//                                    }
//                                  },
//                                  child: Text("Upload",
//                                      textAlign: TextAlign.center,
//                                      style: style.copyWith(
//                                          color: Colors.white, fontWeight: FontWeight.bold)),
//                                ),
//                              ),
//
//                            ]
//                        )
//                    )
//                )
//            )
//        )
//    );
//  }
//}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/job_provider/provider_feed.dart';

class JobPosting extends StatefulWidget {
  JobPosting({Key Key, this.title}) : super(key: Key);
  final String title;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  _JobPostingState createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  String user = globals.userId;

  TextStyle style = TextStyle(fontSize: 14.0);
  final TextEditingController _categoryFilter = new TextEditingController();
  final TextEditingController _jobNameFilter = new TextEditingController();
  final TextEditingController _salaryFilter = new TextEditingController();
  final TextEditingController _startDateFilter = new TextEditingController();
  final TextEditingController _endDateFilter = new TextEditingController();
  final TextEditingController _locationFilter = new TextEditingController();
  final TextEditingController _shortDescFilter = new TextEditingController();
  final TextEditingController _longDescFilter = new TextEditingController();
  final TextEditingController _yoeFilter = new TextEditingController();

  List<String> _experience = ['0', '1', '2', '3', '4', '5'];
  List<String> _category = ['Salesperson', 'Maid', 'Cleaner', 'Store helper'];
  List<bool> _categoryValue = [false, false, false];
  String _selectedCategory = '';
  String sc = '';

  bool _autoValidate = false;
  String _selectedExperience;

  @override
  void initState() {
    super.initState();
    sc = _category.elementAt(0);
    widget.formKey = GlobalKey<FormState>();
    setState(() {

    });
  }

  void dispose() {
    _categoryFilter.dispose();
    _jobNameFilter.dispose();
    _salaryFilter.dispose();
    _startDateFilter.dispose();
    _endDateFilter.dispose();
    _locationFilter.dispose();
    _shortDescFilter.dispose();
    _longDescFilter.dispose();
    _yoeFilter.dispose();
    super.dispose();
  }

  DateTime startSelected;
  final format = DateFormat("dd-MM-yyyy");
  DateTime endSelected;
  DateTime postedOn = DateTime.now();

  _showDateTimePicker() async {
    startSelected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {
      print(startSelected);
    });
  }

  _showDateTimePicker1() async {
    endSelected = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    setState(() {
      print(endSelected);
    });
  }

  void _showDialog() {
    // flutter defined function
    Fluttertoast.showToast(
        msg: "Please enter all the fields",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void pushData() async {
    String jobId = '';
    await Firestore.instance.collection('Jobs').add({
      "description": {
        "short": _shortDescFilter.text,
        "detailed": _longDescFilter.text,
      },
      "period": {
        "start_date": (startSelected.toString().split(" "))[0],
        "end_date": (endSelected.toString().split(" "))[0],
      },
      "location": _locationFilter.text,
      "salary": _salaryFilter.text,
      "title": _jobNameFilter.text,
      "category": sc,
      "yoe": _selectedExperience,
      "provider_id": user,
      "postedOn": (postedOn.toString().split(" "))[0],
      "applicants": new List(),
      "favourite": new List(),
      "approved": new List()
    }).then((doc) {
      jobId = doc.documentID;
    });
    await Firestore.instance.collection("Provider").document(user).updateData({
      "Jobs": FieldValue.arrayUnion([jobId]),
    });

    setState(() {});
  }

  Widget buildService(BuildContext context, int index, List list) {
    String _key = list.elementAt(index);
//    String sc = list.elementAt(0);
//    sc = list.elementAt(0)
    return Container(
      child: Card(
        elevation: 0,
        child: RadioListTile(
          activeColor: Colors.black,
          value: _key,
          groupValue: sc,
          title: Text(_key),
          onChanged: (value) {
            setState(() {
              sc = value;
              print("RadioButtonBuilder: $sc");
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Text("Post a job"),
          backgroundColor: Colors.black,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: KeyboardAvoider(
                autoScroll: true,
                child: Form(
                    key: widget.formKey,
                    autovalidate: _autoValidate,
                    child: SingleChildScrollView(
                        child:
                            Column(mainAxisAlignment: MainAxisAlignment.center,
//                            crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    height: 8.0,
                                  ),
                          Center(
                            child: Text("Job Vacancy Details", style: TextStyle(color: Colors.black, fontSize: 18.0),),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                            controller: _jobNameFilter,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                    new Icon(Icons.work, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("job_title"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the Job name';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                            controller: _shortDescFilter,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon: new Icon(Icons.description,
                                    color: Colors.white),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("short_desc"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a short description';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                            controller: _longDescFilter,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                new Icon(Icons.description, color: Colors.white),
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("long_desc"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a long description';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                                  Divider(
                                    height: 2.0,
                                    color: Colors.black45,
                                  ),
                          Center(
                              child: Text("Select Proficiency", style: TextStyle(color: Colors.black, fontSize: 18.0),)),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _category.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildService(
                                      context, index, _category);
                                }),
                          ),
                                  Divider(
                                    height: 2.0,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                          Center(
                              child: Text("Additional Details", style: TextStyle(color: Colors.black, fontSize: 18.0),)),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                            controller: _salaryFilter,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                new Icon(Icons.attach_money, color: Colors.white),
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("salary"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return 'Please enter the salary';
//                              }
//                              return null;
//                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          InkWell(
                            onTap: () {
                              _showDateTimePicker();
                            },
                            child: IgnorePointer(
                              child: new TextFormField(
                                controller: _startDateFilter,
                                style: TextStyle(color: Colors.white, fontSize: 18.0),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black,
                                    prefixIcon: new Icon(Icons.date_range, color:Colors.white),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Application Start-Date",
                                    labelText: startSelected == null
                                        ? "Application Start-Date"
                                        : (startSelected
                                            .toString()
                                            .split(" "))[0],
                                    labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
//                                    maxLength: 10,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter some text';
//                                      }
//                                      return null;
//                                    },
                                onSaved: (String val) {},
                              ),
                            ),
                          ),
//                              Text('Basic date field (${format.pattern})'),
//                              DateTimeField(
//                                format: format,
//                                onShowPicker: (context, currentValue) {
//                                  return showDatePicker(
//                                      context: context,
//                                      firstDate: DateTime(1900),
//                                      initialDate: currentValue ?? DateTime.now(),
//                                      lastDate: DateTime(2100));
//                                },
//                              ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          InkWell(
                            onTap: () {
                              _showDateTimePicker1();
                            },
                            child: IgnorePointer(
                              child: new TextFormField(
                                controller: _endDateFilter,
                                style: TextStyle(color: Colors.white, fontSize: 18.0),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black,
                                    prefixIcon: new Icon(Icons.date_range, color: Colors.white),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Application End-Date",
                                    labelText: endSelected == null
                                        ? "Application End-Date"
                                        : (endSelected
                                            .toString()
                                            .split(" "))[0],
                                    labelStyle: TextStyle(color: Colors.white, fontSize: 18.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0))),
//                                    maxLength: 10,
//                                    validator: (value) {
//                                      if (value.isEmpty) {
//                                        return 'Please enter some text';
//                                      }
//                                      return null;
//                                    },
                                onSaved: (String val) {},
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style:  TextStyle(color: Colors.white, fontSize: 18.0),
                            controller: _locationFilter,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                prefixIcon:
                                new Icon(Icons.location_on, color: Colors.white),
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: AppTranslations.of(context)
                                    .text("location"),
                                hintStyle: TextStyle(color: Colors.grey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(4.0))),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter the location';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.0),
                            ),
                            child: DropdownButton(
                              elevation: 0,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text(
                                  'Experience(yrs)', style: TextStyle(fontSize: 18)), // Not necessary for Option 1
                              value: _selectedExperience,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedExperience = newValue;
                                });
                              },
                              items: _experience.map((experience) {
                                return DropdownMenuItem(
                                  child: new Text(experience),
                                  value: experience,
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Material(
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.black,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              onPressed: ()  async{
                                if (widget.formKey.currentState.validate()) {
                                   await  pushData();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProviderFeed()),
                                  );
                                } else {
                                  _showDialog();
                                }
                              },
                              child: Text("Upload",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                    fontSize: 18.0,)),
                            ),
                          ),
                        ]))))));
  }
}
