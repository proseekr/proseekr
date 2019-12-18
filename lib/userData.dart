import 'package:flutter/material.dart';

class userData{
   String _firstName = "";
   String _lastName = "";
   String _storeName = "";
   String _addressLine = "";
   String _city = "";
   String _state = "";
   String _pincode = "";
   String _contact = "";
   String _email = "";
   String _username = "";
   String _password = "";

   String get username => _username;

   void setUsername(String value) {
     _username = value;
   }



   @override
   String toString() {
     return 'userData{_firstName: $_firstName, _lastName: $_lastName, _storeName: $_storeName, _addressLine: $_addressLine, _city: $_city, _state: $_state, _pincode: $_pincode, _contact: $_contact, _email: $_email}';
   }
   void setFullName( String fn, String ln ) {   //B
     _firstName = fn;
     _lastName = ln;
   }

   String get firstName => _firstName;

   void setFirstName(String value) {
     _firstName = value;
   }


   String get lastName => _lastName;

   void setLastName(String value) {
     _lastName = value;
   }

   String get addressLine => _addressLine;

   void setAddressLine(String value) {
     _addressLine = value;
   }

   String get city => _city;

   void setCity(String value) {
     _city = value;
   }

   String get state => _state;

   void setState(String value) {
     _state = value;
   }

   String get pincode => _pincode;

   String get storeName => _storeName;

   void setStoreName(String value) {
     _storeName = value;
   }

   void setPincode(String value) {
     _pincode = value;
   }

   String get contact => _contact;

   void setContact(String value) {
     _contact = value;
   }

   String get email => _email;

   void setEmail(String value) {
     _email = value;
   }

   String get password => _password;

   void setPassword(String value) {
     _password = value;
   }
}