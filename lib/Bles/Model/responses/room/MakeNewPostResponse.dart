class MakeNewPostToRoomResponse {
  Data _data;
  dynamic _message;
  int _code;

  MakeNewPostToRoomResponse({Data data, dynamic message, int code}) {
    this._data = data;
    this._message = message;
    this._code = code;
  }

  Data get data => _data;
  set data(Data data) => _data = data;
  dynamic get message => _message;
  set message(dynamic message) => _message = message;
  int get code => _code;
  set code(int code) => _code = code;

  MakeNewPostToRoomResponse.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != dynamic ? new Data.fromJson(json['data']) : dynamic;
    _message = json['message'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != dynamic) {
      data['data'] = this._data.toJson();
    }
    data['message'] = this._message;
    data['code'] = this._code;
    return data;
  }
}

class Data {
  String _roomId;
  String _userId;
  String _postBody;
  String _createdAt;
  int _id;

  Data(
      {String roomId,
        String userId,
        String postBody,
        String createdAt,
        int id}) {
    this._roomId = roomId;
    this._userId = userId;
    this._postBody = postBody;
    this._createdAt = createdAt;
    this._id = id;
  }

  String get roomId => _roomId;
  set roomId(String roomId) => _roomId = roomId;
  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get postBody => _postBody;
  set postBody(String postBody) => _postBody = postBody;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  int get id => _id;
  set id(int id) => _id = id;

  Data.fromJson(Map<String, dynamic> json) {
    _roomId = json['room_id'];
    _userId = json['user_id'];
    _postBody = json['post_body'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this._roomId;
    data['user_id'] = this._userId;
    data['post_body'] = this._postBody;
    data['created_at'] = this._createdAt;
    data['id'] = this._id;
    return data;
  }
}