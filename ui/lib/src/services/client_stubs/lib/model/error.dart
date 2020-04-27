part of openapi.api;

class Error {
  
  int code;
  String messages;

  Error();

  @override
  String toString() {
    return 'Error[code=$code, messages=$messages, ]';
  }

  Error.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code = json['code'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (code != null)
      json['code'] = code;
    if (messages != null)
      json['messages'] = messages;
    return json;
  }

  static List<Error> listFromJson(List<dynamic> json) {
    return json == null ? List<Error>() : json.map((value) => Error.fromJson(value)).toList();
  }

  static Map<String, Error> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Error>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Error.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Error-objects as value to a dart map
  static Map<String, List<Error>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Error>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Error.listFromJson(value);
       });
     }
     return map;
  }
}

