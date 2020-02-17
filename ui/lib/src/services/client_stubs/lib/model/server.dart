part of openapi.api;

class Server {
  
  int userCount = null;
  
  String appVersion = null;
  Server();

  @override
  String toString() {
    return 'Server[userCount=$userCount, appVersion=$appVersion, ]';
  }

  Server.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    userCount = json['userCount'];
    appVersion = json['appVersion'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (userCount != null)
      json['userCount'] = userCount;
    if (appVersion != null)
      json['appVersion'] = appVersion;
    return json;
  }

  static List<Server> listFromJson(List<dynamic> json) {
    return json == null ? List<Server>() : json.map((value) => Server.fromJson(value)).toList();
  }

  static Map<String, Server> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Server>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Server.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Server-objects as value to a dart map
  static Map<String, List<Server>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Server>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Server.listFromJson(value);
       });
     }
     return map;
  }
}

