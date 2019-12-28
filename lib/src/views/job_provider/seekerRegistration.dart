import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/job_seeker/imageUpload.dart';

class SeekerRegistration extends StatefulWidget {
  SeekerRegistration({Key Key, this.title}) : super(key: Key);
  final String title;

  @override
  _SeekerRegistrationState createState() => _SeekerRegistrationState();
}

class _SeekerRegistrationState extends State<SeekerRegistration> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontSize: 14.0);
  final TextEditingController _firstNameFilter = new TextEditingController();
  final TextEditingController _lastNameFilter = new TextEditingController();
  final TextEditingController _contactFilter = new TextEditingController();
  final TextEditingController _genderFilter = new TextEditingController();
  final TextEditingController _emailFilter = new TextEditingController();

  final TextEditingController _address1Filter = new TextEditingController();
  final TextEditingController _cityFilter = new TextEditingController();
  final TextEditingController _stateFilter = new TextEditingController();
  final TextEditingController _pincodeFilter = new TextEditingController();

  final TextEditingController _qualificationsFilter =
      new TextEditingController();
  final TextEditingController _categoryFilter = new TextEditingController();
  final TextEditingController _experienceFilter = new TextEditingController();
  final TextEditingController _expertiseFilter = new TextEditingController();
  final TextEditingController _languageFilter = new TextEditingController();
  List<String> _genders = ['Male', 'Female', 'Others'];
  List<String> _qualification = ['Below 10th', '10th', '12th'];
  List<String> _experience = ['1', '2', '3', '4', '5'];
  List<String> _language = ['English', 'Hindi', 'Telugu'];
  String _selectedGender;
  String _selectedQualification;
  String _selectedExperience;
  List<bool> inputs = new List<bool>();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      for (int i = 0; i < 20; i++) {
        inputs.add(true);
      }
    });
  }

  void ItemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  void dispose() {
    _firstNameFilter.dispose();
    _lastNameFilter.dispose();
    _genderFilter.dispose();
    _contactFilter.dispose();
    _emailFilter.dispose();
    _address1Filter.dispose();
    _cityFilter.dispose();
    _stateFilter.dispose();
    _pincodeFilter.dispose();
    _qualificationsFilter.dispose();
    _categoryFilter.dispose();
    _expertiseFilter.dispose();
    _experienceFilter.dispose();
    _languageFilter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _validateEmail(String value) {
      print("email validator called");
      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
          "\\@" +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
          "(" +
          "\\." +
          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
          ")+";
      RegExp regExp = new RegExp(p);

      if (regExp.hasMatch(value)) {
        // So, the email is valid
        return null;
      }

      // The pattern of the email didn't match the regex above.
      return 'Email is not valid';
    }

    String _phoneNumberValidator(String value) {
      Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty || !regex.hasMatch(value))
        return 'Enter Valid Phone Number';
      else
        return null;
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

    bool _autoValidate = false;
    // TODO: implement build

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
                        child: Text("PERSONAL INFORMATION", style: style),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              style: style,
                              controller: _firstNameFilter,
                              decoration: InputDecoration(
                                  prefixIcon: new Icon(Icons.person),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "First Name",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              validator: (value) {
                                print('validator called');
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextFormField(
                                obscureText: false,
                                style: style,
                                controller: _lastNameFilter,
                                decoration: InputDecoration(
                                    prefixIcon: new Icon(Icons.person),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Last Name",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                                validator: (value) {
                                  print('validator called');
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              style: style,
                              keyboardType: TextInputType.number,
                              controller: _contactFilter,
                              decoration: InputDecoration(
                                  prefixIcon: new Icon(Icons.person),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Contact",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(32.0))),
                              validator: (value) {
                                print('validator called');
                                if (value.isEmpty) {
                                  return _phoneNumberValidator(value);
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03)),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TextFormField(
                                obscureText: false,
                                style: style,
                                controller: _emailFilter,
                                decoration: InputDecoration(
                                    prefixIcon: new Icon(Icons.person),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                                validator: (value) {
                                  print('validator called');
                                  if (value.isEmpty) {
                                    return _validateEmail(value);
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Center(
                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: DropdownButton(
                          hint: Text(
                              'Please choose a gender'), // Not necessary for Option 1
                          value: _selectedGender,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedGender = newValue;
                              globals.seeker.setGender(_selectedGender);
                            });
                          },
                          items: _genders.map((gender) {
                            return DropdownMenuItem(
                              child: new Text(gender),
                              value: gender,
                            );
                          }).toList(),
                        ),
                      )),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Center(
                        child: Text("ADDRESS", style: style),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      TextFormField(
                        obscureText: false,
                        style: style,
                        controller: _address1Filter,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(Icons.home),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Address Line 1",
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
                      TextFormField(
                        obscureText: false,
                        style: style,
                        controller: _cityFilter,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(Icons.location_on),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "City",
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
                      TextFormField(
                        obscureText: false,
                        style: style,
                        controller: _stateFilter,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(Icons.location_on),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "State",
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
                      TextFormField(
                        obscureText: false,
                        style: style,
                        keyboardType: TextInputType.number,
                        controller: _pincodeFilter,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(Icons.location_on),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Pincode",
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
                      Center(
                          child: Text("ADDITIONAL INFORMATION", style: style)),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Container(
                        child: Row(children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child: DropdownButton(
                              hint: Text(
                                  'Please choose your qualification'), // Not necessary for Option 1
                              value: _selectedQualification,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedQualification = newValue;
                                  globals.seeker
                                      .setGender(_selectedQualification);
                                });
                              },
                              items: _qualification.map((qualification) {
                                return DropdownMenuItem(
                                  child: new Text(qualification),
                                  value: qualification,
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child: DropdownButton(
                              hint: Text(
                                  'Please choose your experience(yrs)'), // Not necessary for Option 1
                              value: _selectedExperience,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedExperience = newValue;
                                  globals.seeker.setGender(_selectedExperience);
                                });
                              },
                              items: _experience.map((experience) {
                                return DropdownMenuItem(
                                  child: new Text(experience),
                                  value: experience,
                                );
                              }).toList(),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      TextFormField(
                        obscureText: false,
                        style: style,
                        controller: _expertiseFilter,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(Icons.location_on),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Expertise (if any)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              globals.seeker
                                  .setFirstName(_firstNameFilter.text);
                              globals.seeker.setLastName(_lastNameFilter.text);
                              globals.seeker.setContact(_contactFilter.text);
                              globals.seeker.setEmail(_emailFilter.text);
                              globals.seeker
                                  .setAddressLine(_address1Filter.text);
                              globals.seeker.setCity(_cityFilter.text);
                              globals.seeker.setState(_stateFilter.text);
                              globals.seeker.setPincode(_pincodeFilter.text);
                              globals.seeker
                                  .setQualification(_qualificationsFilter.text);
                              globals.seeker
                                  .setExperience(_experienceFilter.text);
                              globals.seeker
                                  .setExpertise(_expertiseFilter.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeekerImageUpload()),
                              );
//                              print('No error');
                            } else {
                              _showDialog();
                            }
                          },
                          child: Text("Next",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                    ],
                  ),
                )),
          ),
        ));
  }
}
