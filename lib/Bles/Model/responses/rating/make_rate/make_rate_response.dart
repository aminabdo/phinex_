import 'package:dio/dio.dart';

class MakeRateResponse extends Response {
  Data _data;
  dynamic _message;
  dynamic _code;

  Data get data => _data;

  dynamic get message => _message;

  dynamic get code => _code;

  MakeRateResponse({Data data, dynamic message, dynamic code}) {
    _data = data;
    _message = message;
    _code = code;
  }

  MakeRateResponse.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
    _code = json["code"];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    map["code"] = _code;
    return map;
  }
}

class Data {
  dynamic _id;
  dynamic _userId;
  dynamic _imageId;
  dynamic _categoryId;
  dynamic _commercialName;
  dynamic _shortDescription;
  dynamic _description;
  dynamic _city;
  dynamic _governorate;
  dynamic _country;
  dynamic _totalReviews;
  dynamic _totalRates;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  dynamic get id => _id;

  dynamic get userId => _userId;

  dynamic get imageId => _imageId;

  dynamic get categoryId => _categoryId;

  dynamic get commercialName => _commercialName;

  dynamic get shortDescription => _shortDescription;

  dynamic get description => _description;

  dynamic get city => _city;

  dynamic get governorate => _governorate;

  dynamic get country => _country;

  dynamic get totalReviews => _totalReviews;

  dynamic get totalRates => _totalRates;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Data(
      {dynamic id,
      dynamic userId,
      dynamic imageId,
      dynamic categoryId,
      dynamic commercialName,
      dynamic shortDescription,
      dynamic description,
      dynamic city,
      dynamic governorate,
      dynamic country,
      dynamic totalReviews,
      dynamic totalRates,
      dynamic createdAt,
      dynamic updatedAt,
      dynamic deletedAt}) {
    _id = id;
    _userId = userId;
    _imageId = imageId;
    _categoryId = categoryId;
    _commercialName = commercialName;
    _shortDescription = shortDescription;
    _description = description;
    _city = city;
    _governorate = governorate;
    _country = country;
    _totalReviews = totalReviews;
    _totalRates = totalRates;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _imageId = json["image_id"];
    _categoryId = json["category_id"];
    _commercialName = json["commercial_name"];
    _shortDescription = json["short_description"];
    _description = json["description"];
    _city = json["city"];
    _governorate = json["governorate"];
    _country = json["country"];
    _totalReviews = json["total_reviews"];
    _totalRates = json["total_rates"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["image_id"] = _imageId;
    map["category_id"] = _categoryId;
    map["commercial_name"] = _commercialName;
    map["short_description"] = _shortDescription;
    map["description"] = _description;
    map["city"] = _city;
    map["governorate"] = _governorate;
    map["country"] = _country;
    map["total_reviews"] = _totalReviews;
    map["total_rates"] = _totalRates;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }
}
