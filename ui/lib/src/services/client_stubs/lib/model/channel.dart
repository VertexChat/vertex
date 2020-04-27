part of openapi.api;

class Channel {
  
  int id;
  String name;
  String type;
  //enum typeEnum {  TEXT,  VOICE,  };{

  Channel();

  @override
  String toString() {
    return 'Channel[id=$id, name=$name, type=$type, ]';
  }

  Channel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (name != null)
      json['name'] = name;
    if (type != null)
      json['type'] = type;
    return json;
  }

  static List<Channel> listFromJson(List<dynamic> json) {
    return json == null ? List<Channel>() : json.map((value) => Channel.fromJson(value)).toList();
  }

  static Map<String, Channel> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Channel>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Channel.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Channel-objects as value to a dart map
  static Map<String, List<Channel>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Channel>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Channel.listFromJson(value);
       });
     }
     return map;
  }
}

