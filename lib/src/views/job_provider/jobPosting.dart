import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class JobPosting extends StatefulWidget {
  JobPosting({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _JobPostingState createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  List<String> _category = ['Plumbing', 'Carpentry', 'Electrical'];
  List<bool> _categoryValue = [false, false, false];

  bool _autoValidate = false;

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

  DateTime selectedDate = DateTime.now();
  // TODO:
  String _value = "";

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
    if (picked != null) setState(() => _value = picked.toString());
  }

  Widget buildService(BuildContext context, int index, List list, List value) {
    String _key = list.elementAt(index);

    return Container(
      child: Card(
        elevation: 0,
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          dense: true,
          onChanged: (bool checkedValue) {
            setState(() {
              value[index] = !value[index];
            });
          },
          value: value[index],
          title: Text(_key),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[250],
        appBar: AppBar(
          title: Text("proseekr"),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: KeyboardAvoider(
                autoScroll: true,
                child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Center(
                            child: Text("JOB VACANCY DETAILS", style: style),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: style,
                            controller: _jobNameFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.store),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Job Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _category.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return buildService(context, index, _category,
                                      _categoryValue);
                                }),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          TextFormField(
                            obscureText: false,
                            style: style,
                            controller: _salaryFilter,
                            decoration: InputDecoration(
                                prefixIcon: new Icon(Icons.store),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: "Salary",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0))),
                            validator: (value) {
                              print('validator called');
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          InkWell(
                            onTap: () {
                              _selectDate(); // Call Function that has showDatePicker()
                            },
                            child: IgnorePointer(
                              child: new TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon: new Icon(Icons.store),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Application Start-Date",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                                maxLength: 10,
                                // validator: validateDob,
                                onSaved: (String val) {},
                              ),
                            ),
                          ),
                        ]))))));
  }
}
