//import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:keyboard_avoider/keyboard_avoider.dart';
//import 'package:proseekr/src/models/globals.dart' as globals;
//import 'package:proseekr/src/views/job_seeker/imageUpload.dart';
//
//class SeekerRegistration extends StatefulWidget {
//  SeekerRegistration({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _SeekerRegistrationState createState() => _SeekerRegistrationState();
//}
//
//class _SeekerRegistrationState extends State<SeekerRegistration> {
//  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  TextStyle style = TextStyle(fontSize: 14.0);
//  final TextEditingController _firstNameFilter = new TextEditingController();
//  final TextEditingController _lastNameFilter = new TextEditingController();
//  final TextEditingController _contactFilter = new TextEditingController();
//  final TextEditingController _passwordFilter = new TextEditingController();
//  final TextEditingController _confirmPasswordFilter = new TextEditingController();
//  final TextEditingController _genderFilter = new TextEditingController();
//  final TextEditingController _emailFilter = new TextEditingController();
//
//  final TextEditingController _address1Filter = new TextEditingController();
//  final TextEditingController _cityFilter = new TextEditingController();
//  final TextEditingController _stateFilter = new TextEditingController();
//  final TextEditingController _pincodeFilter = new TextEditingController();
//
//  final TextEditingController _qualificationsFilter = new TextEditingController();
//  final TextEditingController _categoryFilter = new TextEditingController();
//  final TextEditingController _experienceFilter = new TextEditingController();
//  final TextEditingController _expertiseFilter = new TextEditingController();
//  final TextEditingController _languageFilter = new TextEditingController();
//  List<String> _genders = ['Male', 'Female', 'Others'];
//  List<String> _qualification = ['Below 10th', '10th', '12th'];
//  List<String> _experience = ['0', '1', '2', '3', '4', '5'];
//  List<String> _language = ['English', 'Hindi', 'Telugu'];
//  List<bool> _langValue = [false, false, false];
//  List<String> _category = ['Plumbing', 'Carpentry', 'Electrical'];
//  List<bool> _categoryValue = [false, false, false];
//  String _selectedGender;
//  String _selectedQualification;
//  String _selectedExperience;
//
//  void dispose() {
//    _firstNameFilter.dispose();
//    _lastNameFilter.dispose();
//    _genderFilter.dispose();
//    _contactFilter.dispose();
//    _passwordFilter.dispose();
//    _confirmPasswordFilter.dispose();
//    _emailFilter.dispose();
//    _address1Filter.dispose();
//    _cityFilter.dispose();
//    _stateFilter.dispose();
//    _pincodeFilter.dispose();
//    _qualificationsFilter.dispose();
//    _categoryFilter.dispose();
//    _expertiseFilter.dispose();
//    _experienceFilter.dispose();
//    _languageFilter.dispose();
//    super.dispose();
//  }
//
//  List insertSelected(List<String> list, List<bool> val) {
//    List<String> list1 = new List<String>();
////  print(val.toString());
//    for (var i = 0; i < val.length; i++) {
//      if (val[i] == true) list1.add(list[i]);
//    }
//    print(list1.toString());
//    return list1;
//  }
//  String _validatePassword(String password, String confirmPassword){
//    if(password.isEmpty || confirmPassword.isEmpty)
//      return 'Enter your password';
//    else if(password != confirmPassword)
//      return 'Passwords do not match';
//    else
//      return null;
//  }
//
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
//  @override
//  Widget build(BuildContext context) {
//    print("Seeker reg called...");
//    String _validateEmail(String value) {
//      print("email validator called");
//      String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
//          "\\@" +
//          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
//          "(" +
//          "\\." +
//          "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
//          ")+";
//      RegExp regExp = new RegExp(p);
//
//      if (regExp.hasMatch(value)) {
//        // So, the email is valid
//        return null;
//      }
//
//      // The pattern of the email didn't match the regex above.
//      return 'Email is not valid';
//    }
//
//    String _phoneNumberValidator(String value) {
//      Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
//      RegExp regex = new RegExp(pattern);
//      if (value.isEmpty || !regex.hasMatch(value))
//        return 'Enter Valid Phone Number';
//      else
//        return null;
//    }
//
//    void _showDialog() {
//      // flutter defined function
//      Fluttertoast.showToast(
//          msg: "Please enter all the fields",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.black,
//          textColor: Colors.white,
//          fontSize: 16.0);
//    }
//
//    bool _autoValidate = false;
//
//    return Scaffold(
//        backgroundColor: Colors.grey[250],
//        appBar: AppBar(
//          title: Text("proseekr"),
//        ),
//        body: Container(
//          padding: EdgeInsets.all(20),
//          child: KeyboardAvoider(
//            autoScroll: true,
//            child: Form(
//                key: _formKey,
//                autovalidate: _autoValidate,
//                child: SingleChildScrollView(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.end,
//                    children: <Widget>[
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Center(
//                        child: Text("PERSONAL INFORMATION", style: style),
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: TextFormField(
//                              obscureText: false,
//                              style: style,
//                              controller: _firstNameFilter,
//                              decoration: InputDecoration(
//                                  prefixIcon: new Icon(Icons.person),
//                                  contentPadding: EdgeInsets.fromLTRB(
//                                      20.0, 15.0, 20.0, 15.0),
//                                  hintText: "First Name",
//                                  border: OutlineInputBorder(
//                                      borderRadius:
//                                          BorderRadius.circular(32.0))),
//                              validator: (value) {
//                                print('validator called');
//                                if (value.isEmpty) {
//                                  return 'Please enter some text';
//                                }
//                                return null;
//                              },
//                            ),
//                          ),
//                          Padding(
//                              padding: EdgeInsets.all(
//                                  MediaQuery.of(context).size.width * 0.03)),
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: TextFormField(
//                                obscureText: false,
//                                style: style,
//                                controller: _lastNameFilter,
//                                decoration: InputDecoration(
//                                    prefixIcon: new Icon(Icons.person),
//                                    contentPadding: EdgeInsets.fromLTRB(
//                                        20.0, 15.0, 20.0, 15.0),
//                                    hintText: "Last Name",
//                                    border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(32.0))),
//                                validator: (value) {
//                                  print('validator called');
//                                  if (value.isEmpty) {
//                                    return 'Please enter some text';
//                                  }
//                                  return null;
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: TextFormField(
//                              obscureText: false,
//                              style: style,
//                              keyboardType: TextInputType.number,
//                              controller: _contactFilter,
//                              decoration: InputDecoration(
//                                  prefixIcon: new Icon(Icons.person),
//                                  contentPadding: EdgeInsets.fromLTRB(
//                                      20.0, 15.0, 20.0, 15.0),
//                                  hintText: "Contact",
//                                  border: OutlineInputBorder(
//                                      borderRadius:
//                                          BorderRadius.circular(32.0))),
//                              validator: (value) {
//                                print('validator called');
//                                if (value.isEmpty) {
//                                  return _phoneNumberValidator(value);
//                                }
//                                return null;
//                              },
//                            ),
//                          ),
//                          Padding(padding: EdgeInsets.all(globals.PADDING)),
//                          Expanded(
//                            child: SingleChildScrollView(
//                              child: TextFormField(
//                                obscureText: false,
//                                style: style,
//                                controller: _emailFilter,
//                                decoration: InputDecoration(
//                                    prefixIcon: new Icon(Icons.person),
//                                    contentPadding: EdgeInsets.fromLTRB(
//                                        20.0, 15.0, 20.0, 15.0),
//                                    hintText: "Email",
//                                    border: OutlineInputBorder(
//                                        borderRadius:
//                                            BorderRadius.circular(32.0))),
//                                validator: (value) {
//                                  print('validator called');
//                                  if (value.isEmpty) {
//                                    return _validateEmail(value);
//                                  }
//                                  return null;
//                                },
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Padding(padding: EdgeInsets.all(globals.PADDING)),
//                      TextFormField(
//                        obscureText: true,
//                        style: style,
//                        controller: _passwordFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: Icon(Icons.lock),
//                            contentPadding:
//                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "Enter your Password",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isEmpty) {
//                            return 'Please enter your Password';
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(padding: EdgeInsets.all(globals.PADDING)),
//                      TextFormField(
//                        obscureText: true,
//                        style: style,
//                        controller: _confirmPasswordFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: Icon(Icons.lock),
//                            contentPadding:
//                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "Confirm Password",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isNotEmpty) {
//                            return _validatePassword(_passwordFilter.text, _confirmPasswordFilter.text);;
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(padding: EdgeInsets.all(globals.PADDING)),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Center(
//                          child: Container(
//                        padding: EdgeInsets.symmetric(horizontal: 10.0),
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(32.0),
//                          border: Border.all(
//                              color: Colors.black,
//                              style: BorderStyle.solid,
//                              width: 0.80),
//                        ),
//                        child: DropdownButton(
//                          hint: Text('Please choose a gender'),
//                          elevation: 0,
//                          underline: Container(
//                            height: 0,
//                          ),
//                          value: _selectedGender,
//                          onChanged: (newValue) {
//                            setState(() {
////
//                              _selectedGender = newValue;
//                              globals.seeker.setGender(newValue);
//                              print(globals.seeker.gender);
//                            });
//                          },
//                          items: _genders.map((gender) {
//                            return DropdownMenuItem(
//                              child: new Text(gender),
//                              value: gender,
//                            );
//                          }).toList(),
//                        ),
//                      )),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Center(
//                        child: Text("ADDRESS", style: style),
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      TextFormField(
//                        obscureText: false,
//                        style: style,
//                        controller: _address1Filter,
//                        decoration: InputDecoration(
//                            prefixIcon: new Icon(Icons.home),
//                            contentPadding:
//                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "Address Line 1",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      TextFormField(
//                        obscureText: false,
//                        style: style,
//                        controller: _cityFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: new Icon(Icons.location_on),
//                            contentPadding:
//                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "City",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      TextFormField(
//                        obscureText: false,
//                        style: style,
//                        controller: _stateFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: new Icon(Icons.location_on),
//                            contentPadding:
//                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "State",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      TextFormField(
//                        obscureText: false,
//                        style: style,
//                        keyboardType: TextInputType.number,
//                        controller: _pincodeFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: new Icon(Icons.location_on),
//                            contentPadding:
//                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "Pincode",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                        validator: (value) {
//                          print('validator called');
//                          if (value.isEmpty) {
//                            return 'Please enter some text';
//                          }
//                          return null;
//                        },
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Center(
//                          child: Text("ADDITIONAL INFORMATION", style: style)),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Row(children: <Widget>[
//                            Container(
//                              padding: EdgeInsets.symmetric(horizontal: 10.0),
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(32.0),
//                                border: Border.all(
//                                    color: Colors.black,
//                                    style: BorderStyle.solid,
//                                    width: 0.80),
//                              ),
//                              child: DropdownButton(
//                                elevation: 0,
//                                underline: Container(
//                                  height: 0,
//                                ),
//                                hint: Text(
//                                    'Qualification'), // Not necessary for Option 1
//                                value: _selectedQualification,
//                                onChanged: (newValue) {
//                                  setState(() {
//                                    _selectedQualification = newValue;
//                                    globals.seeker.setQualification(newValue);
//                                  });
//                                },
//                                items: _qualification.map((qualification) {
//                                  return DropdownMenuItem(
//                                    child: Text(qualification),
//                                    value: qualification,
//                                  );
//                                }).toList(),
//                              ),
//                            ),
//                            SizedBox(
//                              width: MediaQuery.of(context).size.width * 0.3,
//                            ),
//                            Container(
//                              padding: EdgeInsets.symmetric(horizontal: 10.0),
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(32.0),
//                                border: Border.all(
//                                    color: Colors.black,
//                                    style: BorderStyle.solid,
//                                    width: 0.80),
//                              ),
//                              child: DropdownButton(
//                                elevation: 0,
//                                underline: Container(
//                                  height: 0,
//                                ),
//                                hint: Text(
//                                    'Experience(yrs)'), // Not necessary for Option 1
//                                value: _selectedExperience,
//                                onChanged: (newValue) {
//                                  setState(() {
//                                    _selectedExperience = newValue;
//                                    globals.seeker.setExperience(newValue);
//                                  });
//                                },
//                                items: _experience.map((experience) {
//                                  return DropdownMenuItem(
//                                    child: new Text(experience),
//                                    value: experience,
//                                  );
//                                }).toList(),
//                              ),
//                            )
//                          ]),
//                        ],
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      TextFormField(
//                        obscureText: false,
//                        style: style,
//                        controller: _expertiseFilter,
//                        decoration: InputDecoration(
//                            prefixIcon: new Icon(Icons.location_on),
//                            contentPadding:
//                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            hintText: "Expertise (if any)",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(32.0))),
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                      Center(child: Text("LANGUAGES KNOWN", style: style)),
//                      Container(
//                        child: ListView.builder(
//                            shrinkWrap: true,
//                            itemCount: _language.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              return buildService(
//                                  context, index, _language, _langValue);
//                            }),
//                      ),
//                      Center(child: Text("SELECT PROFICIENCY", style: style)),
//                      Container(
//                        child: ListView.builder(
//                            shrinkWrap: true,
//                            itemCount: _category.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              return buildService(
//                                  context, index, _category, _categoryValue);
//                            }),
//                      ),
//                      Material(
//                        elevation: 5.0,
//                        borderRadius: BorderRadius.circular(30.0),
//                        color: Colors.black,
//                        child: MaterialButton(
//                          minWidth: MediaQuery.of(context).size.width * 0.3,
//                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                          onPressed: () {
//                            if (_formKey.currentState.validate()) {
//                              globals.seeker.setFirstName(_firstNameFilter.text);
//                              globals.seeker.setLastName(_lastNameFilter.text);
//                              globals.seeker.setContact(_contactFilter.text);
//                              globals.seeker.setPassword(_confirmPasswordFilter.text);
//                              globals.seeker.setEmail(_emailFilter.text);
//                              globals.seeker.setAddressLine(_address1Filter.text);
//                              globals.seeker.setCity(_cityFilter.text);
//                              globals.seeker.setState(_stateFilter.text);
//                              globals.seeker.setPincode(_pincodeFilter.text);
//                              globals.seeker.setExpertise(_expertiseFilter.text);
//                              globals.seeker.setLanguages(insertSelected(_language, _langValue));
//                              globals.seeker.setCategory(insertSelected(_category, _categoryValue));
//                              print(globals.seeker.toString());
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => SeekerImageUpload()),
////                                MaterialPageRoute(builder: (context) => JobPosting()),
//                              );
////                              print('No error');
//                            } else {
//                              _showDialog();
//                            }
//                          },
//                          child: Text("Next",
//                              textAlign: TextAlign.center,
//                              style: style.copyWith(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold)),
//                        ),
//                      ),
//                      Padding(
//                          padding: EdgeInsets.all(
//                              MediaQuery.of(context).size.width * 0.03)),
//                    ],
//                  ),
//                )),
//          ),
//        ));
//  }
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:proseekr/src/i18n/app_translations.dart';
import 'package:proseekr/src/models/globals.dart' as globals;
import 'package:proseekr/src/views/job_seeker/imageUpload.dart';

class SeekerRegistration extends StatefulWidget {
  SeekerRegistration({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SeekerRegistrationState createState() => _SeekerRegistrationState();
}

class _SeekerRegistrationState extends State<SeekerRegistration> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontSize: 14.0, color: Colors.white);
  final TextEditingController _firstNameFilter = new TextEditingController();
  final TextEditingController _lastNameFilter = new TextEditingController();
  final TextEditingController _contactFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _confirmPasswordFilter =
      new TextEditingController();
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
  List<String> _experience = ['0', '1', '2', '3', '4', '5'];
  List<String> _language = ['English', 'हिन्दी', 'తెలుగు'];
  List<bool> _langValue = [false, false, false];
  List<String> _category = ['Salesperson', 'Maid', 'Cleaner', 'Store helper'];
  List<bool> _categoryValue = [false, false, false, false];
  String _selectedGender;
  String _selectedQualification;
  String _selectedExperience;

  void dispose() {
    _firstNameFilter.dispose();
    _lastNameFilter.dispose();
    _genderFilter.dispose();
    _contactFilter.dispose();
    _emailFilter.dispose();
    _passwordFilter.dispose();
    _confirmPasswordFilter.dispose();
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

  List insertSelected(List<String> list, List<bool> val) {
    List<String> list1 = new List<String>();
//  print(val.toString());
    for (var i = 0; i < val.length; i++) {
      if (val[i] == true) list1.add(list[i]);
    }
    print(list1.toString());
    return list1;
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
    print("Seeker reg called...");
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
      return AppTranslations.of(context).text('Email is not valid');
    }

    String _validatePassword(String password, String confirmPassword) {
      if (password.isEmpty || confirmPassword.isEmpty)
        return AppTranslations.of(context).text('Enter your password');
      else if (password != confirmPassword)
        return AppTranslations.of(context).text('Passwords do not match');
      else
        return null;
    }

    String _phoneNumberValidator(String value) {
      Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty || !regex.hasMatch(value))
        return AppTranslations.of(context).text('Enter Valid Phone Number');
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

    return Scaffold(
        appBar: AppBar(
          title: Text(AppTranslations.of(context).text("seeker_registration")),
          backgroundColor: Colors.black,
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
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24.0),
//                      Text(
//                          child: ),
                      Text(
                          AppTranslations.of(context)
                                  .text("personal_information") ??
                              "Personal Information",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _firstNameFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.person, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText:
                                AppTranslations.of(context).text("first_name"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter your First name');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _lastNameFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.person, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText:
                                AppTranslations.of(context).text("last_name"),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter your Last name');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: _passwordFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.lock, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText:
                                AppTranslations.of(context).text("password"),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter your Password');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        controller: _confirmPasswordFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.lock, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: AppTranslations.of(context)
                                .text("confirm_password"),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isNotEmpty) {
                            return _validatePassword(_passwordFilter.text,
                                _confirmPasswordFilter.text);
                            ;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 0.80),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                    AppTranslations.of(context).text("gender")),
                                elevation: 0,
                                underline: Container(
                                  height: 0,
                                ),
                                value: _selectedGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedGender = newValue;
                                    globals.seeker.setGender(newValue);
                                    print(globals.seeker.gender);
                                  });
                                },
                                items: _genders.map((gender) {
                                  return DropdownMenuItem(
                                    child: Text(AppTranslations.of(context)
                                        .text(gender.toLowerCase())),
                                    value: gender,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              obscureText: false,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              controller: _contactFilter,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.black,
                                  prefixIcon:
                                      new Icon(Icons.call, color: Colors.white),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: AppTranslations.of(context)
                                      .text("contact"),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.0))),
                              validator: (value) {
                                print('validator called');
                                if (value.isEmpty) {
                                  return _phoneNumberValidator(value);
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _emailFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon: new Icon(Icons.mail_outline,
                                color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: AppTranslations.of(context).text("email"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return _validateEmail(value);
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      Divider(
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      Center(
                        child: Text(
                            AppTranslations.of(context).text("address_line"),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _address1Filter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.home, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: AppTranslations.of(context)
                                .text("address_line"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter the Address');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _cityFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon: new Icon(Icons.location_city,
                                color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: AppTranslations.of(context).text("city"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter the City');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _stateFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon: new Icon(Icons.location_on,
                                color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: AppTranslations.of(context).text("state"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter the State');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        controller: _pincodeFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon: new Icon(Icons.location_on,
                                color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText:
                                AppTranslations.of(context).text("pin_code"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                        validator: (value) {
                          print('validator called');
                          if (value.isEmpty) {
                            return AppTranslations.of(context)
                                .text('Please enter the Pincode');
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      Center(
                          child: Text(
                              AppTranslations.of(context)
                                  .text("Additional Information"),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(height: 24.0),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child: DropdownButton(
                              elevation: 0,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text(AppTranslations.of(context)
                                  .text("qualification")),
                              value: _selectedQualification,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedQualification = newValue;
                                  globals.seeker.setQualification(newValue);
                                });
                              },
                              items: _qualification.map((qualification) {
                                return DropdownMenuItem(
                                  child: Text(qualification),
                                  value: qualification,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0.80),
                            ),
                            child: DropdownButton(
                              elevation: 0,
                              underline: Container(
                                height: 0,
                              ),
                              hint: Text(AppTranslations.of(context)
                                  .text("experience")),
                              value: _selectedExperience,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedExperience = newValue;
                                  globals.seeker.setExperience(newValue);
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
                        )
                      ]),
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03)),
                      TextFormField(
                        obscureText: false,
                        style: TextStyle(color: Colors.white),
                        controller: _expertiseFilter,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black,
                            prefixIcon:
                                new Icon(Icons.loyalty, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText:
                                AppTranslations.of(context).text("expertise"),
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(4.0))),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                          child: Text(
                              AppTranslations.of(context)
                                  .text("Languages Known"),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _language.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildService(
                                  context, index, _language, _langValue);
                            }),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                          child: Text(
                              AppTranslations.of(context)
                                  .text("Select Proficiency"),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _category.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildService(
                                  context, index, _category, _categoryValue);
                            }),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Material(
                        shape: CircleBorder(),
                        color: Colors.black,
                        child: MaterialButton(
                          elevation: 8.0,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              globals.seeker
                                  .setFirstName(_firstNameFilter.text);
                              globals.seeker.setLastName(_lastNameFilter.text);
                              globals.seeker.setContact(_contactFilter.text);
                              globals.seeker.setEmail(_emailFilter.text);
                              globals.seeker
                                  .setPassword(_confirmPasswordFilter.text);
                              globals.seeker
                                  .setAddressLine(_address1Filter.text);
                              globals.seeker.setCity(_cityFilter.text);
                              globals.seeker.setState(_stateFilter.text);
                              globals.seeker.setPincode(_pincodeFilter.text);
                              globals.seeker
                                  .setExpertise(_expertiseFilter.text);
                              globals.seeker.setLanguages(
                                  insertSelected(_language, _langValue));
                              globals.seeker.setCategory(
                                  insertSelected(_category, _categoryValue));
                              print(globals.seeker.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeekerImageUpload()),
//                                MaterialPageRoute(builder: (context) => JobPosting()),
                              );
//                              print('No error');
                            } else {
                              _showDialog();
                            }
                          },
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      )
                    ],
                  ),
                )),
          ),
        ));
  }
}
