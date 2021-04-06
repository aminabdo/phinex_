
class FriendsCountResponse {
  Data _data;
  dynamic _message;
  int _code;

  Data get data => _data;
  dynamic get message => _message;
  int get code => _code;

  FriendsCountResponse({
      Data data, 
      dynamic message, 
      int code}){
    _data = data;
    _message = message;
    _code = code;
}

  FriendsCountResponse.fromJson(dynamic json) {
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

/// friends_requests : 0
/// friends : 2

class Data {
  int _friendsRequests;
  int _friends;

  int get friendsRequests => _friendsRequests;
  int get friends => _friends;

  Data({
      int friendsRequests, 
      int friends}){
    _friendsRequests = friendsRequests;
    _friends = friends;
}

  Data.fromJson(dynamic json) {
    _friendsRequests = json["friends_requests"];
    _friends = json["friends"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["friends_requests"] = _friendsRequests;
    map["friends"] = _friends;
    return map;
  }

}