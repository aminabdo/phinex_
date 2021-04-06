class SingleChatWithAdminResponse {
  Data _data;
  List<Message> _message;
  int _code;

  Data get data => _data;
  List<Message> get message => _message;
  int get code => _code;

  SingleChatWithAdminResponse({
      Data data, 
      dynamic message, 
      int code,
  }){
    _data = data;
    _message = message;
    _code = code;
}

  SingleChatWithAdminResponse.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    map["code"] = _code;
    return map;
  }

}

class Data {
  Message _message;

  Message get message => _message;

  Data({
      Message message}){
    _message = message;
}

  Data.fromJson(dynamic json) {
    _message = json["message"] != null ? Message.fromJson(json["message"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_message != null) {
      map["message"] = _message.toJson();
    }
    return map;
  }

}

class Message {
  String _chatId;
  String _userId;
  String _content;
  String _updatedAt;
  String _createdAt;
  int _id;
  Chat _chat;
  dynamic _attachment;

  String get chatId => _chatId;
  String get userId => _userId;
  String get content => _content;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;
  Chat get chat => _chat;
  dynamic get attachment => _attachment;

  Message({
      String chatId, 
      String userId, 
      String content, 
      String updatedAt, 
      String createdAt, 
      int id, 
      Chat chat, 
      dynamic attachment}){
    _chatId = chatId;
    _userId = userId;
    _content = content;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _chat = chat;
    _attachment = attachment;
}

  Message.fromJson(dynamic json) {
    _chatId = json["chat_id"];
    _userId = json["user_id"];
    _content = json["content"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
    _chat = json["chat"] != null ? Chat.fromJson(json["chat"]) : null;
    _attachment = json["attachment"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["chat_id"] = _chatId;
    map["user_id"] = _userId;
    map["content"] = _content;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    if (_chat != null) {
      map["chat"] = _chat.toJson();
    }
    map["attachment"] = _attachment;
    return map;
  }

}

class Chat {
  int _id;
  String _title;
  dynamic _imageId;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  List<Subscriptions> _subscriptions;

  int get id => _id;
  String get title => _title;
  dynamic get imageId => _imageId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  List<Subscriptions> get subscriptions => _subscriptions;

  Chat({
      int id, 
      String title, 
      dynamic imageId, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
      List<Subscriptions> subscriptions}){
    _id = id;
    _title = title;
    _imageId = imageId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _subscriptions = subscriptions;
}

  Chat.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _imageId = json["image_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    if (json["subscriptions"] != null) {
      _subscriptions = [];
      json["subscriptions"].forEach((v) {
        _subscriptions.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["image_id"] = _imageId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    if (_subscriptions != null) {
      map["subscriptions"] = _subscriptions.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Subscriptions {
  int _id;
  int _chatId;
  int _userId;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;

  int get id => _id;
  int get chatId => _chatId;
  int get userId => _userId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;

  Subscriptions({
      int id, 
      int chatId, 
      int userId, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt}){
    _id = id;
    _chatId = chatId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
}

  Subscriptions.fromJson(dynamic json) {
    _id = json["id"];
    _chatId = json["chat_id"];
    _userId = json["user_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["chat_id"] = _chatId;
    map["user_id"] = _userId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }

}