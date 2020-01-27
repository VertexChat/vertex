// https://dart.dev/tutorials/web/fetch-data

class User {
  //Variables
  String _email;
  String _password;
  String _displayName;
  String _groups;

  User.map(dynamic obj) {
    this._email = obj['email'];
    this._password = obj['password'];
    this._displayName = obj['displayName'];
    this._groups = obj['groups'];
  }

  String get email => _email;

  String get password => _password;

  String get displayName => _displayName;

  String get groups => _groups;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = _email;
    map["password"] = _password;
    map['displayName'] = _displayName;
    map['groups'] = _groups;
    return map;
  } //End
} //End class
