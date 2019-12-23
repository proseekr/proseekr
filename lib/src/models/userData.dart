import 'dart:io';
class ProviderData{
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _storeName = "";
  String _addressLine = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  String _contact = "";
  String _email = "";
  String _imageURL = "";
  String _documentURL = "";
  String get imageURL => _imageURL;
  File _imageFile;

  File get imageFile => _imageFile;

  void setImageFile(File value) {
    _imageFile = value;
  }

  void setImageURL(String value) {
    _imageURL = value;
  }


  @override
  String toString() {
    return 'userData{_firstName: $_firstName, _lastName: $_lastName, _gender: $_gender, _storeName: $_storeName, _addressLine: $_addressLine, _city: $_city, _state: $_state, _pincode: $_pincode, _contact: $_contact, _email: $_email, _imageURL: $_imageURL, _documentURL: $_documentURL}';
  }

  String get gender => _gender;

  void setGender(String value) {
    _gender = value;
  }


  @override

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

  String get documentURL => _documentURL;

  void setDocumentURL(String value) {
    _documentURL = value;
  }
}

class SeekerData{
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _contact = "";
  String _email = "";
  String _addressLine = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  String _qualification = "";
  List<String> _category;
  String _experience = "";
  String _expertise = "";
  List<String> _languages;

  String get firstName => _firstName;

  void setFirstName(String value) {
    _firstName = value;
  }

  String get contact => _contact;

  void setContact(String value) {
    _contact = value;
  }

  String get email => _email;

  void setEmail(String value) {
    _email = value;
  }

  String get addressLine => _addressLine;

  void setAddressLine(String value) {
    _addressLine = value;
  }

  String get city => _city;

  void setCity(String value) {
    _city = value;
  }

  String get pincode => _pincode;

  void setPincode(String value) {
    _pincode = value;
  }

  String get qualification => _qualification;

  void setQualification(String value) {
    _qualification = value;
  }

  String get lastName => _lastName;

  void setLastName(String value) {
    _lastName = value;
  }

  List<String> get category => _category;

  void setCategory(List<String> value) {
    _category = value;
  }

  String get expertise => _expertise;

  void setExpertise(String value) {
    _expertise = value;
  }

  List<String> get languages => _languages;

  void setLanguages(List<String> value) {
    _languages = value;
  }

  String get gender => _gender;

  void setGender(String value) {
    _gender = value;
  }

  String get state => _state;

  void setState(String value) {
    _state = value;
  }

  String get experience => _experience;

  void setExperience(String value) {
    _experience = value;
  }
}
