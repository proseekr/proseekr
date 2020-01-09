library proseekr.globals;

import 'package:proseekr/src/models/userData.dart';

//application-wide data models
ProviderData provider = ProviderData();
SeekerData seeker = SeekerData();

// application-wide constants
enum SelectedActor { JobProvider, JobSeeker, None }

// application-wide styles
const double PADDING = 8.0;

String loggedInActor = "";
String userId = "";
bool hasNewMessage = false;
