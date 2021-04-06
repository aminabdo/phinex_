class MyAuctionsResponse {
  List<Data> _data;
  dynamic _message;
  int _code;

  List<Data> get data => _data;
  dynamic get message => _message;
  int get code => _code;

  MyAuctionsResponse({
      List<Data> data, 
      dynamic message, 
      int code}){
    _data = data;
    _message = message;
    _code = code;
}

  MyAuctionsResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _message = json["message"];
    _code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    map["code"] = _code;
    return map;
  }

}

class Data {
  int _id;
  String _title;
  int _sellerId;
  dynamic _reference;
  dynamic _videoId;
  int _imageId;
  int _categoryId;
  String _description;
  String _opensFrom;
  String _endsAt;
  int _incrementValue;
  int _openPrice;
  String _status;
  int _isVip;
  int _totalPaids;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  String _imageUrl;

  int get id => _id;
  String get title => _title;
  int get sellerId => _sellerId;
  dynamic get reference => _reference;
  dynamic get videoId => _videoId;
  int get imageId => _imageId;
  int get categoryId => _categoryId;
  String get description => _description;
  String get opensFrom => _opensFrom;
  String get endsAt => _endsAt;
  int get incrementValue => _incrementValue;
  int get openPrice => _openPrice;
  String get status => _status;
  int get isVip => _isVip;
  int get totalPaids => _totalPaids;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String get imageUrl => _imageUrl;

  Data({
      int id, 
      String title, 
      int sellerId, 
      dynamic reference, 
      dynamic videoId, 
      int imageId, 
      int categoryId, 
      String description, 
      String opensFrom, 
      String endsAt, 
      int incrementValue, 
      int openPrice, 
      String status, 
      int isVip, 
      int totalPaids, 
      String createdAt, 
      String updatedAt, 
      dynamic deletedAt, 
      String imageUrl}){
    _id = id;
    _title = title;
    _sellerId = sellerId;
    _reference = reference;
    _videoId = videoId;
    _imageId = imageId;
    _categoryId = categoryId;
    _description = description;
    _opensFrom = opensFrom;
    _endsAt = endsAt;
    _incrementValue = incrementValue;
    _openPrice = openPrice;
    _status = status;
    _isVip = isVip;
    _totalPaids = totalPaids;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _imageUrl = imageUrl;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _title = json["title"];
    _sellerId = json["seller_id"];
    _reference = json["reference"];
    _videoId = json["video_id"];
    _imageId = json["image_id"];
    _categoryId = json["category_id"];
    _description = json["description"];
    _opensFrom = json["opens_from"];
    _endsAt = json["ends_at"];
    _incrementValue = json["increment_value"];
    _openPrice = json["open_price"];
    _status = json["status"];
    _isVip = json["is_vip"];
    _totalPaids = json["total_paids"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    _imageUrl = json["image_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["title"] = _title;
    map["seller_id"] = _sellerId;
    map["reference"] = _reference;
    map["video_id"] = _videoId;
    map["image_id"] = _imageId;
    map["category_id"] = _categoryId;
    map["description"] = _description;
    map["opens_from"] = _opensFrom;
    map["ends_at"] = _endsAt;
    map["increment_value"] = _incrementValue;
    map["open_price"] = _openPrice;
    map["status"] = _status;
    map["is_vip"] = _isVip;
    map["total_paids"] = _totalPaids;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    map["image_url"] = _imageUrl;
    return map;
  }

}