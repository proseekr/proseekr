import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../job_seeker/userProfile.dart';
import 'pdfUpload.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class UserLogin extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => UserLoginState();
}

class UserLoginState extends State<UserLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final FirebaseUser user = await _auth.currentUser();
                if (user == null) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: const Text('No one has signed in.'),
                  ));
                  return;
                }
                _signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[


            PhoneSignInSection(Scaffold.of(context)),

          ],
        );
      }),
    );
  }

  // Example code for sign out.
  void _signOut() async {
    await _auth.signOut();
  }
}

FirebaseUser user;
class PhoneSignInSection extends StatefulWidget {
  PhoneSignInSection(this.scaffold);

  final ScaffoldState scaffold;
  @override
  State<StatefulWidget> createState() => PhoneSignInSectionState();

  String userGetter() {
    return user.uid.toString();
  }
}

class PhoneSignInSectionState extends State<PhoneSignInSection> {

  TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);


  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  String _message = '';
  String _verificationId;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical :300.0),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width-100,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Phone Number",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//          onPressed:
            ),
          ),
//;
          Container(
            width: MediaQuery.of(context).size.width-100,
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: TextField(
              controller: _smsController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter OTP",
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
            ),
          ),

          Container(
              margin: EdgeInsets.symmetric(horizontal: 58),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width-400,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          _verifyPhoneNumber();
                        },
                        child: Text("Generate OTP",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.blue,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width-300,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          _signInWithPhoneNumber();
                          print(_phoneNumberController.text+"st1");
                        },
                        child: Text("Submit",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              )
          ),

          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _message,
              style: TextStyle(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  // Exmaple code of how to veify phone number
  void _verifyPhoneNumber() async {
    setState(() {
      _message = 'Verify Phone Number';
    });



/*Redirects to Desired Page When sucessfull Login*/
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential phoneAuthCredential)
    {
      _auth.signInWithCredential(phoneAuthCredential).then((user){
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));

      }

      );

      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';

      }
      );


    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _message =
        'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
        print(_phoneNumberController.text+"st2");
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      widget.scaffold.showSnackBar(SnackBar(
        content:
        const Text('Please check your phone for the verification code.'),
      ));
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91"+_phoneNumberController.text,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout

    );
    print(_phoneNumberController.text+"st3");
  }


  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsController.text,
    );
    user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Successfully signed in, uid: ' + user.uid;
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
      }

      else {
        _message = 'Sign in failed';
      }
    });
  }
}
