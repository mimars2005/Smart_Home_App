
class Account {
  String _username = "";
  String get username => _username;
  void set username(String newUsername) {
    _username = newUsername;
  }

  String _firstName = "";
  String get firstName => _firstName;
  void set firstName(String newfirstName) {
    _firstName = newfirstName;
  }

  String _lastName = "";
  String get lastName => _lastName;
  void set lastName(String newlastName) {
    _lastName = newlastName;
  }

  String _email = "";
  String get email => _email;
  void set email(String newEmail) {
    _email = newEmail;
  }

  String _password = "";
  String get password => _password;
  void set password(String newpassword) {
    _password = newpassword;
  }

  String _phoneNumber = "";
  String get phoneNumber => _phoneNumber;
  void set phoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
  }
}
