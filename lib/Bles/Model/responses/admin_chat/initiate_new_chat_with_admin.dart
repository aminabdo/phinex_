import 'package:phinex/Bles/Model/responses/admin_chat/single_chat_with_admin_response.dart';

class InitiateNewChatWithAdmin {
  Data _data;
  dynamic _message;
  int _code;

  Data get data => _data;
  dynamic get message => _message;
  int get code => _code;

  InitiateNewChatWithAdmin({
      Data data, 
      dynamic message, 
      int code}){
    _data = data;
    _message = message;
    _code = code;
}

  InitiateNewChatWithAdmin.fromJson(dynamic json) {
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
  int _id;
  String _title;
  dynamic _imageId;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  List<dynamic> _messages;

  int get id => _id;
  String get title => _title;
  dynamic get imageId => _imageId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  List<Message> get messages => _messages;

  Data({
      int id, 
      String title, 
      dynamic imageId, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
      List<Message> messages,
  }){

    _id = id;
    _title = title;
    _imageId = imageId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _messages = messages;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _imageId = json["image_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    if (json["messages"] != null) {
      _messages = [];
      json["messages"].forEach((v) {
        _messages.add(Message.fromJson(v));
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
    if (_messages != null) {
      map["messages"] = _messages.map((v) => v.toJson()).toList();
    }
    return map;
  }

}