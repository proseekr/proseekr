import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: UserProfile(title: "Proseekr"),
//      debugShowCheckedModeBanner: false,
//    );
//  }
//}
class UserProfile extends StatefulWidget{
  UserProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserProfileState createState() => _UserProfileState();
}
class _UserProfileState extends State<UserProfile> {
  @override
  static Map<String, dynamic> userDetails = {};
  static Map _basicdetails = {};
  static Map _address = {};
  String full_name = "";
  String city = "";
  String contact = "";
  String basic_qualification = "";
  List<dynamic> category;
      Future<Null> getUser() async {
    await Firestore.instance
        .collection('Seeker') // Your Collections Name
        .document('kPnpHRIQb4y56MakRtr7')  // Your user Document Name
        .get()
        .then((val) {
      userDetails.addAll(val.data);
    }).whenComplete(() {
      print('Data Fetched');
      print(userDetails['basic_qualification']);
      _basicdetails = userDetails['basic_details'];
      _address = userDetails['address'];
      full_name = _basicdetails['first_name'] +" "+ _basicdetails['last_name'];
      contact = _basicdetails['contact'];
      city = _address['city'];
      basic_qualification = userDetails['basic_qualification'];
      category = userDetails['category'];
      print(category.toString());
      print(city);
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
//          SizedBox.expand(
//            child: Image.asset("assets/user.jpg", fit: BoxFit.cover,),
//          ),
          FloatingActionButton(
            onPressed: getUser,
          ),
          DraggableScrollableSheet(
            minChildSize: 0.1,
            initialChildSize: 0.22,
            builder: (context, scrollController){
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //for user profile header
                            Container(
                              padding : EdgeInsets.only(left: 32, right: 32, top: 32),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
//                            SizedBox(
//                                height: 100,
//                                width: 100,
//                                child: ClipOval(
//                                  child: Image.asset('assets/user.jpg', fit: BoxFit.cover,),
//                                )
//                            ),

                                  SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        
                                        Text(full_name, style: TextStyle(color: Colors.grey[800], fontFamily: "Roboto",
                                            fontSize: 36, fontWeight: FontWeight.w700
                                        ),),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                          Text("Location : "+ city, style: TextStyle(color: Colors.grey[500], fontFamily: "Roboto",
                                              fontSize: 16, fontWeight: FontWeight.w400
                                          ),),
                                              Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2)),
                                      Text("Contact : "+ contact, style: TextStyle(color: Colors.grey[500], fontFamily: "Roboto",
                                              fontSize: 16, fontWeight: FontWeight.w400
                                          ),),
                                    ],
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),
//                                  Icon(Icons.sms, color: Colors.blue, size: 40,)
                                ],
                              ),
                            ),

                            //performace bar

                            SizedBox(height: 16,),
                            Container(
                              padding: EdgeInsets.all(32),
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.equalizer, color: Colors.white, size: 30,),
                                          SizedBox(width: 4,),
                                          Text("Basic Qualification", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,
                                              fontFamily: "Roboto", fontSize: 20
                                          ),)
                                        ],
                                      ),

                                      Text(basic_qualification, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto", fontSize: 12
                                      ),)
                                    ],
                                  ),

                                  Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.work, color: Colors.white, size: 30,),
                                          SizedBox(width: 4,),
                                          Text("Expertise", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,
                                              fontFamily: "Roboto", fontSize: 20
                                          ),)
                                        ],
                                      ),

                                      Text(category.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto", fontSize: 12
                                      ),)
                                    ],
                                  ),

                                  Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.star, color: Colors.white, size: 30,),
                                          SizedBox(width: 4,),
                                          Text("5", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,
                                              fontFamily: "Roboto", fontSize: 24
                                          ),)
                                        ],
                                      ),

                                      Text("Ratings", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,
                                          fontFamily: "Roboto", fontSize: 15
                                      ),)
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16,),
                            //container for about me

                            Container(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              child: Column(
                                children: <Widget>[
                                  Text("About Me", style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w700,
                                      fontFamily: "Roboto", fontSize: 18
                                  ),),

                                  SizedBox(height: 8,),
                                  Text("Hello, this is maaz, and I am from easy approach, and this is just a demo text for information about me"
                                      "Hello, this is maaz, and I am from easy approach, and this is just a demo text for information about me",
                                    style: TextStyle(fontFamily: "Roboto", fontSize: 15),
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(height: 16,),
                            //Container for clients

                            Container(
                              padding: EdgeInsets.only(left: 32, right: 32),
                              child: Column(
                                children: <Widget>[

                                  //for list of clients
//                            Container(
//                              width: MediaQuery.of(context).size.width-64,
//                              height: 80,
//                              child: ListView.builder(
//                                itemBuilder: (context, index) {
//                                  return Container(
//                                    width: 80,
//                                    height: 80,
//                                    margin: EdgeInsets.only(right: 8),
//                                    child: ClipOval(child: Image.asset("assets/${index+1}.jpg", fit: BoxFit.cover,),),
//                                  );
//                                },
//                                itemCount: 5,
//                                scrollDirection: Axis.horizontal,
//                                shrinkWrap: true,
//                              ),
//                            )
//
//                          ],
//                        ),
//                      ),

                                  SizedBox(height: 16,),

                                  //Container for reviews

                                  Container(
                                    padding: EdgeInsets.only(left: 32, right: 32),
                                    child: Column(
                                      children: <Widget>[
                                        Text("Reviews", style: TextStyle(color: Colors.grey[800], fontSize: 18, fontFamily: "Roboto",
                                            fontWeight: FontWeight.w700
                                        ),),


                                        Center(
                                          child: Container(
//                                width: MediaQuery.of(context).size.width-64,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Text("Client $index", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "Roboto",
                                                            fontWeight: FontWeight.w700
                                                        )),

//                                          Row(
//                                            children: <Widget>[
//                                              Icon(Icons.star, color: Colors.orangeAccent,),
//                                              Icon(Icons.star, color: Colors.orangeAccent,),
//                                              Icon(Icons.star, color: Colors.orangeAccent,),
//                                            ],
//                                          ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8,),

                                                    Text("He is very fast and good at his work", style: TextStyle(color: Colors.grey[800], fontSize: 14, fontFamily: "Roboto",
                                                        fontWeight: FontWeight.w400
                                                    )),
                                                    SizedBox(height: 16,),
                                                  ],
                                                );
                                              },
                                              itemCount: 8,
                                              shrinkWrap: true,
                                              controller: ScrollController(keepScrollOffset: false),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )


                                ],
                              ),

                            ),
                          ]
                      )
                  )
              );
            },
          )
        ],
      ),
    );
  }
}
