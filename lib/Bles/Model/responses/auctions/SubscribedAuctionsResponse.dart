class SubscribedAuctionsResponse {
  List<Paid> _paid;
  List<Deals> _deals;

  List<Paid> get paid => _paid;

  List<Deals> get deals => _deals;

  SubscribedAuctionsResponse({List<Paid> paid, List<Deals> deals}) {
    _paid = paid;
    _deals = deals;
  }

  SubscribedAuctionsResponse.fromJson(dynamic json) {
    if (json["paid"] != null) {
      _paid = [];
      json["paid"].forEach((v) {
        _paid.add(Paid.fromJson(v));
      });
    }
    if (json["deals"] != null) {
      _deals = [];
      json["deals"].forEach((v) {
        _deals.add(Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_paid != null) {
      map["paid"] = _paid.map((v) => v.toJson()).toList();
    }
    if (_deals != null) {
      map["deals"] = _deals.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Deals {
  dynamic _id;
  String _title;
  dynamic _sellerId;
  dynamic _reference;
  dynamic _videoId;
  dynamic _imageId;
  dynamic _categoryId;
  String _description;
  String _opensFrom;
  String _endsAt;
  dynamic _incrementValue;
  dynamic _openPrice;
  String _status;
  dynamic _isVip;
  dynamic _totalPaids;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  String _imageUrl;

  dynamic get id => _id;

  String get title => _title;

  dynamic get sellerId => _sellerId;

  dynamic get reference => _reference;

  dynamic get videoId => _videoId;

  dynamic get imageId => _imageId;

  dynamic get categoryId => _categoryId;

  String get description => _description;

  String get opensFrom => _opensFrom;

  String get endsAt => _endsAt;

  dynamic get incrementValue => _incrementValue;

  dynamic get openPrice => _openPrice;

  String get status => _status;

  dynamic get isVip => _isVip;

  double get totalPaids => _totalPaids;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  String get imageUrl => _imageUrl;

  Deals(
      {dynamic id,
      String title,
      dynamic sellerId,
      dynamic reference,
      dynamic videoId,
        dynamic imageId,
        dynamic categoryId,
      String description,
      String opensFrom,
      String endsAt,
        dynamic incrementValue,
        dynamic openPrice,
      String status,
        dynamic isVip,
      double totalPaids,
      String createdAt,
      String updatedAt,
      dynamic deletedAt,
      String imageUrl}) {
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

  Deals.fromJson(dynamic json) {
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

class Paid {
  dynamic _id;
  String _title;
  dynamic _sellerId;
  dynamic _reference;
  dynamic _videoId;
  dynamic _imageId;
  dynamic _categoryId;
  String _description;
  String _opensFrom;
  String _endsAt;
  dynamic _incrementValue;
  dynamic _openPrice;
  String _status;
  dynamic _isVip;
  dynamic _totalPaids;
  String _createdAt;
  String _updatedAt;
  dynamic _deletedAt;
  String _imageUrl;

  dynamic get id => _id;

  String get title => _title;

  dynamic get sellerId => _sellerId;

  dynamic get reference => _reference;

  dynamic get videoId => _videoId;

  dynamic get imageId => _imageId;

  dynamic get categoryId => _categoryId;

  String get description => _description;

  String get opensFrom => _opensFrom;

  String get endsAt => _endsAt;

  dynamic get incrementValue => _incrementValue;

  dynamic get openPrice => _openPrice;

  String get status => _status;

  dynamic get isVip => _isVip;

  dynamic get totalPaids => _totalPaids;

  String get createdAt => _createdAt;

  String get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  String get imageUrl => _imageUrl;

  Paid(
      {dynamic id,
      String title,
        dynamic sellerId,
      dynamic reference,
      dynamic videoId,
      dynamic imageId,
      dynamic categoryId,
      String description,
      String opensFrom,
      String endsAt,
      dynamic incrementValue,
        dynamic openPrice,
      String status,
      dynamic isVip,
      dynamic totalPaids,
      String createdAt,
      String updatedAt,
      dynamic deletedAt,
      String imageUrl}) {
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

  Paid.fromJson(dynamic json) {
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
