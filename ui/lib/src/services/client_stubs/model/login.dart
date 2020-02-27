part of openapi.api;

class Login {
  
  String password;
  String userName;

  Login();

  @override
  String toString() {
    return 'Login[password=$password, userName=$userName, ]';
  }

  Login.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    password = json['password'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (password != null)
      json['password'] = password;
    if (userName != null)
      json['userName'] = userName;
    return json;
  }

  static List<Login> listFromJson(List<dynamic> json) {
    return json == null ? List<Login>() : json.map((value) => Login.fromJson(value)).toList();
  }

  static Map<String, Login> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Login>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Login.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Login-objects as value to a dart map
  static Map<String, List<Login>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Login>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Login.listFromJson(value);
       });
     }
     return map;
  }
}

