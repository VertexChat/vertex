part of openapi.api;

class Message {
  int id;
  int channelId;
  int userId;
  String content;
  String timestamp;
  String editedTimestamp;

  Message();

  @override
  String toString() {
    return 'Message[id=$id, channelId=$channelId, userId=$userId, content=$content, timestamp=$timestamp, editedTimestamp=$editedTimestamp, ]';
  }

  Message.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    channelId = json['channel_id'];
    userId = json['user_id'];
    content = json['content'];
    timestamp = json['timestamp'];
    editedTimestamp = json['edited_timestamp'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (channelId != null) json['channel_id'] = channelId;
    if (userId != null) json['user_id'] = userId;
    if (content != null) json['content'] = content;
    if (timestamp != null) json['timestamp'] = timestamp;
    if (editedTimestamp != null) json['edited_timestamp'] = editedTimestamp;
    return json;
  }

  static List<Message> listFromJson(List<dynamic> json) {
    return json == null
        ? List<Message>()
        : json.map((value) => Message.fromJson(value)).toList();
  }

  static Map<String, Message> mapFromJson(Map<String, dynamic> json) {
    var map = Map<String, Message>();
    if (json != null && json.isNotEmpty) {
      json.forEach(
          (String key, dynamic value) => map[key] = Message.fromJson(value));
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
