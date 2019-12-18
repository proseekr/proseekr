class UserData {
  String _firstName = "";
  String _lastName = "";
  String _storeName = "";
  String _addressLine = "";
  String _city = "";
  String _state = "";
  String _pinCode = "";
  String _contact = "";
  String _email = "";
  String _username = "";
  String _password = "";

  @override
  String toString() {
    return 'userData {'
        '_firstName: $_firstName, '
        '_lastName: $_lastName, '
        '_storeName: $_storeName, '
        '_addressLine: $_addressLine, '
        '_city: $_city, '
        '_state: $_state, '
        '_pinCode: $_pinCode,'
        ' _contact: $_contact, '
        '_email: $_email }';
  }

  // All setters must be declared here

  void setFullName(String fn, String ln) {
    _firstName = fn;
    _lastName = ln;
  }

  void setUsername(String value) {
    _username = value;
  }

  void setFirstName(String value) {
    _firstName = value;
  }

  void setLastName(String value) {
    _lastName = value;
  }

  void setAddressLine(String value) {
    _addressLine = value;
  }

  void setCity(String value) {
    _city = value;
  }

  void setState(String value) {
    _state = value;
  }

  void setStoreName(String value) {
    _storeName = value;
  }

  void setPinCode(String value) {
    _pinCode = value;
  }

  void setContact(String value) {
    _contact = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setPassword(String value) {
    _password = value;
  }

  // All getters must be declared here

  String get username => _username;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get addressLine => _addressLine;

  String get city => _city;

  String get state => _state;

  String get pinCode => _pinCode;

  String get storeName => _storeName;

  String get contact => _contact;

  String get email => _email;

  String get password => _password;
}
