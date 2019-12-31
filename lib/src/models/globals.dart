library proseekr.globals;

import 'package:proseekr/src/models/userData.dart';

//application-wide data models
ProviderData obj = ProviderData();
SeekerData seeker = SeekerData();

// application-wide constants
enum SelectedActor { JobProvider, JobSeeker, None }
//final FirebaseUser n = user;
const String STORAGE_BUCKET_URL = 'gs://b4di-b4d4c.appspot.com';

// application-wide styles
const double PADDING = 8.0;

String loggedInActor = "";
String userId = "";
bool newMessage = false;
