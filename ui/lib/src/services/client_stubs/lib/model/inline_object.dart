part of openapi.api;

class InlineObject {
  String username;
  String password;

  InlineObject();

  @override
  String toString() {
    return 'InlineObject[name=$username, password=$password]' ;
  }

  InlineObject.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    username = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (username != null) json['name'] = username;
    if (password != null) json['password'] = password;
    return json;
  }

  static List<InlineObject> listFromJson(List<dynamic> json) {
    return json == null
        ? List<InlineObject>()
        : json.map((value) => InlineObject.fromJson(value)).toList();
  }

  static Map<String, InlineObject> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, InlineObject>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) =>
          map[key] = InlineObject.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of InlineObject-objects as value to a dart map
  static Map<String, List<InlineObject>> mapListFromJson(
      Map<String, dynamic> json) {
    var map = Map<String, List<InlineObject>>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) {
        map[key] = InlineObject.listFromJson(value);
      });
    }
    return map;
  }
}
