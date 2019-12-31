import 'dart:io';

class ProviderData {
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _storeName = "";
  String _addressLine = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  String _contact = "";
  String _password = "";
  String _email = "";
  String _imageURL = "";
  String _documentURL = "";
  String get imageURL => _imageURL;
  File _imageFile;

  String get password => _password;

  void setPassword(String value) {
    _password = value;
  }



  String get firstName => _firstName;

  String get lastName => _lastName;

  @override
  String toString() {
    return 'ProviderData{_firstName: $_firstName, _lastName: $_lastName, _gender: $_gender, _storeName: $_storeName, _addressLine: $_addressLine, _city: $_city, _state: $_state, _pincode: $_pincode, _contact: $_contact, _password: $_password, _email: $_email, _imageURL: $_imageURL, _documentURL: $_documentURL, _imageFile: $_imageFile}';
  }

  File get imageFile => _imageFile;

  String get gender => _gender;

  String get addressLine => _addressLine;

  String get city => _city;

  String get state => _state;

  String get pincode => _pincode;

  String get storeName => _storeName;

  String get contact => _contact;

  String get email => _email;

  String get documentURL => _documentURL;

  void setFullName(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
  }

  void setFirstName(String firstName) => _firstName = firstName;

  void setImageURL(String value) => _imageURL = value;

  void setImageFile(File value) => _imageFile = value;

  void setGender(String value) => _gender = value;

  void setLastName(String value) => _lastName = value;

  void setAddressLine(String value) => _addressLine = value;

  void setCity(String value) => _city = value;

  void setState(String value) => _state = value;

  void setStoreName(String value) => _storeName = value;

  void setPincode(String value) => _pincode = value;

  void setContact(String value) => _contact = value;

  void setEmail(String value) => _email = value;

  void setDocumentURL(String value) => _documentURL = value;
}
class SeekerData {
  String _firstName = "";
  String _lastName = "";
  String _gender = "";
  String _contact = "";
  String _password = "";

  String get password => _password;

  void setPassword(String value) {
    _password = value;
  }

  String _email = "";
  String _addressLine = "";
  String _city = "";
  String _state = "";
  String _pincode = "";
  String _qualification = "";
  List<String> _category;
  String _experience = "";
  String _expertise = "";

  String get imageURL => _imageURL;

  void setImageURL(String value) {
    _imageURL = value;
  }

  String _imageURL = "";
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
