part of openapi.api;

class Message {
  
  int id;
  int channel;
  int author;
  String content;
  int timestamp;


  Message({this.channel, this.author, this.content, this.timestamp});

  @override
  String toString() {
    return 'Message[id=$id, channel=$channel, author=$author, content=$content, timestamp=$timestamp, ]';
  }

  Message.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    channel = json['channel'];
    author = json['author'];
    content = json['content'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    Map <String, dynamic> json = {};
    if (id != null)
      json['id'] = id;
    if (channel != null)
      json['channel'] = channel;
    if (author != null)
      json['author'] = author;
    if (content != null)
      json['content'] = content;
    if (timestamp != null)
      json['timestamp'] = timestamp;
    return json;
  }

  static List<Message> listFromJson(List<dynamic> json) {
    return json == null ? List<Message>() : json.map((value) => Message.fromJson(value)).toList();
  }

  static Map<String, Message> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Message>();
    if (json != null && json.isNotEmpty) {
      json.forEach((String key, dynamic value) => map[key] = Message.fromJson(value));
    }
    return map;
  }

  // maps a json object with a list of Message-objects as value to a dart map
  static Map<String, List<Message>> mapListFromJson(Map<String, dynamic> json) {
    var map = Map<String, List<Message>>();
     if (json != null && json.isNotEmpty) {
       json.forEach((String key, dynamic value) {
         map[key] = Message.listFromJson(value);
       });
     }
     return map;
  }
}

