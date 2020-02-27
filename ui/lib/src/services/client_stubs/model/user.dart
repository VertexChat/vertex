part of openapi.api;

class User {

  int id;
  String username;
  /* In the case of user creation the password field will be the plaintext password in all other instances where the server returns a User object it will be a combination of the hash of the users password and associated salt */
  String password;
  String displayName;

  // Constructor
  User();

  @override
  String toString() {
    return 'User[id=$id, username=$username, password=$password, displayName=$displayName, ]';
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    username = json['username'];
    password = json['password'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (username != null)
      json['username'] = username;
    if (password != null)
      json['password'] = password;
    if (displayName != null)
      json['displayName'] = displayName;
    return json;
  }

  static List<User> listFromJson(List<dynamic> json) {
    return json == null ? List<User>() : json.map((value) =>
        User.fromJson(value)).toList();
  }

  static Map<String, User> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, User>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) =>
      map[key] = User.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of User-objects as value to a dart map
  static Map<String, List<User>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<User>>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) {
        map[key] = User.listFromJson(value);
      });
    }
    return map;
  }
}

