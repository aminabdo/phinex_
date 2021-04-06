class RestaurantSingleResponse {
  Data _data;
  dynamic _message;
  dynamic _code;

  Data get data => _data;
  dynamic get message => _message;
  dynamic get code => _code;

  RestaurantSingleResponse({
      Data data,
      dynamic message,
      dynamic code}){
    _data = data;
    _message = message;
    _code = code;
}

  RestaurantSingleResponse.fromJson(dynamic json) {
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
  dynamic _title;
  dynamic _userId;
  dynamic _logoId;
  dynamic _coverImageId;
  dynamic _country;
  dynamic _governorate;
  dynamic _city;
  dynamic _address;
  dynamic _longitude;
  dynamic _latitude;
  dynamic _phone;
  dynamic _email;
  dynamic _website;
  dynamic _description;
  dynamic _totalReviews;
  dynamic _totalRates;
  dynamic _deliveryStatus;
  dynamic _saturday;
  dynamic _sunday;
  dynamic _monday;
  dynamic _tuesday;
  dynamic _wednesday;
  dynamic _thursday;
  dynamic _friday;
  dynamic _openAt;
  dynamic _closingAt;
  dynamic _estimatedDeliveryTime;
  dynamic _restaurantId;
  dynamic _logoUrl;
  dynamic _coverImageUrl;
  List<Products> _products;
  List<Rates> _rates;
  List<dynamic> _gallery;

  void setTotalRates(dynamic rates) {
    _totalRates = rates;
  }

  void setTotalReviews(dynamic rates) {
    _totalReviews = rates;
  }

  dynamic get title => _title;
  dynamic get userId => _userId;
  dynamic get logoId => _logoId;
  dynamic get coverImageId => _coverImageId;
  dynamic get country => _country;
  dynamic get governorate => _governorate;
  dynamic get city => _city;
  dynamic get address => _address;
  dynamic get longitude => _longitude;
  dynamic get latitude => _latitude;
  dynamic get phone => _phone;
  dynamic get email => _email;
  dynamic get website => _website;
  dynamic get description => _description;
  dynamic get totalReviews => _totalReviews;
  dynamic get totalRates => _totalRates;
  dynamic get deliveryStatus => _deliveryStatus;
  dynamic get saturday => _saturday;
  dynamic get sunday => _sunday;
  dynamic get monday => _monday;
  dynamic get tuesday => _tuesday;
  dynamic get wednesday => _wednesday;
  dynamic get thursday => _thursday;
  dynamic get friday => _friday;
  dynamic get openAt => _openAt;
  dynamic get closingAt => _closingAt;
  dynamic get estimatedDeliveryTime => _estimatedDeliveryTime;
  dynamic get restaurantId => _restaurantId;
  dynamic get logoUrl => _logoUrl;
  dynamic get coverImageUrl => _coverImageUrl;
  List<Products> get products => _products;
  List<Rates> get rates => _rates;
  List<dynamic> get gallery => _gallery;

  Data({
      dynamic title,
      dynamic userId,
      dynamic logoId,
      dynamic coverImageId,
      dynamic country,
      dynamic governorate,
      dynamic city,
      dynamic address,
      dynamic longitude,
      dynamic latitude,
      dynamic phone,
      dynamic email,
      dynamic website,
      dynamic description,
      dynamic totalReviews,
      dynamic totalRates,
      dynamic deliveryStatus,
      dynamic saturday,
      dynamic sunday,
      dynamic monday,
      dynamic tuesday,
      dynamic wednesday,
      dynamic thursday,
      dynamic friday,
      dynamic openAt,
      dynamic closingAt,
      dynamic estimatedDeliveryTime,
      dynamic restaurantId,
      dynamic logoUrl,
      dynamic coverImageUrl,
      List<Products> products,
      List<Rates> rates,
      List<dynamic> gallery}){
    _title = title;
    _userId = userId;
    _logoId = logoId;
    _coverImageId = coverImageId;
    _country = country;
    _governorate = governorate;
    _city = city;
    _address = address;
    _longitude = longitude;
    _latitude = latitude;
    _phone = phone;
    _email = email;
    _website = website;
    _description = description;
    _totalReviews = totalReviews;
    _totalRates = totalRates;
    _deliveryStatus = deliveryStatus;
    _saturday = saturday;
    _sunday = sunday;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _openAt = openAt;
    _closingAt = closingAt;
    _estimatedDeliveryTime = estimatedDeliveryTime;
    _restaurantId = restaurantId;
    _logoUrl = logoUrl;
    _coverImageUrl = coverImageUrl;
    _products = products;
    _rates = rates;
    _gallery = gallery;
}

  Data.fromJson(dynamic json) {
    _title = json["title"];
    _userId = json["user_id"];
    _logoId = json["logo_id"];
    _coverImageId = json["cover_image_id"];
    _country = json["country"];
    _governorate = json["governorate"];
    _city = json["city"];
    _address = json["address"];
    _longitude = json["longitude"];
    _latitude = json["latitude"];
    _phone = json["phone"];
    _email = json["email"];
    _website = json["website"];
    _description = json["description"];
    _totalReviews = json["total_reviews"];
    _totalRates = json["total_rates"];
    _deliveryStatus = json["delivery_status"];
    _saturday = json["saturday"];
    _sunday = json["sunday"];
    _monday = json["monday"];
    _tuesday = json["tuesday"];
    _wednesday = json["wednesday"];
    _thursday = json["thursday"];
    _friday = json["friday"];
    _openAt = json["open_at"];
    _closingAt = json["closing_at"];
    _estimatedDeliveryTime = json["estimated_delivery_time"];
    _restaurantId = json["RestaurantId"];
    _logoUrl = json["logo_url"];
    _coverImageUrl = json["cover_image_url"];
    if (json["products"] != null) {
      _products = [];
      json["products"].forEach((v) {
        _products.add(Products.fromJson(v));
      });
    }
    if (json["rates"] != null) {
      _rates = [];
      json["rates"].forEach((v) {
        _rates.add(Rates.fromJson(v));
      });
    }
    if (json["gallery"] != null) {
      _gallery = [];
      json["gallery"].forEach((v) {
        _gallery.add(v);
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["title"] = _title;
    map["user_id"] = _userId;
    map["logo_id"] = _logoId;
    map["cover_image_id"] = _coverImageId;
    map["country"] = _country;
    map["governorate"] = _governorate;
    map["city"] = _city;
    map["address"] = _address;
    map["longitude"] = _longitude;
    map["latitude"] = _latitude;
    map["phone"] = _phone;
    map["email"] = _email;
    map["website"] = _website;
    map["description"] = _description;
    map["total_reviews"] = _totalReviews;
    map["total_rates"] = _totalRates;
    map["delivery_status"] = _deliveryStatus;
    map["saturday"] = _saturday;
    map["sunday"] = _sunday;
    map["monday"] = _monday;
    map["tuesday"] = _tuesday;
    map["wednesday"] = _wednesday;
    map["thursday"] = _thursday;
    map["friday"] = _friday;
    map["open_at"] = _openAt;
    map["closing_at"] = _closingAt;
    map["estimated_delivery_time"] = _estimatedDeliveryTime;
    map["RestaurantId"] = _restaurantId;
    map["logo_url"] = _logoUrl;
    map["cover_image_url"] = _coverImageUrl;
    if (_products != null) {
      map["products"] = _products.map((v) => v.toJson()).toList();
    }
    if (_rates != null) {
      map["rates"] = _rates.map((v) => v.toJson()).toList();
    }
    if (_gallery != null) {
      map["gallery"] = _gallery;
    }
    return map;
  }

}

class Rates {
  dynamic _id;
  dynamic _rate;
  dynamic _comment;
  dynamic _userId;
  dynamic _objectId;
  dynamic _categoryId;
  dynamic _objectName;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;
  User _user;

  dynamic get id => _id;
  dynamic get rate => _rate;
  dynamic get comment => _comment;
  dynamic get userId => _userId;
  dynamic get objectId => _objectId;
  dynamic get categoryId => _categoryId;
  dynamic get objectName => _objectName;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  User get user => _user;

  Rates({
      dynamic id,
      dynamic rate,
      dynamic comment,
      dynamic userId,
      dynamic objectId,
      dynamic categoryId,
      dynamic objectName,
      dynamic createdAt,
      dynamic updatedAt,
      dynamic deletedAt,
      User user}){
    _id = id;
    _rate = rate;
    _comment = comment;
    _userId = userId;
    _objectId = objectId;
    _categoryId = categoryId;
    _objectName = objectName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _user = user;
}

  Rates.fromJson(dynamic json) {
    _id = json["id"];
    _rate = json["rate"];
    _comment = json["comment"];
    _userId = json["user_id"];
    _objectId = json["object_id"];
    _categoryId = json["category_id"];
    _objectName = json["object_name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["rate"] = _rate;
    map["comment"] = _comment;
    map["user_id"] = _userId;
    map["object_id"] = _objectId;
    map["category_id"] = _categoryId;
    map["object_name"] = _objectName;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }

}

class User {
  dynamic _id;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _username;
  dynamic _phone;
  dynamic _phoneVerifiedAt;
  dynamic _type;
  dynamic _chanel;
  dynamic _imageUrl;

  dynamic get id => _id;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get username => _username;
  dynamic get phone => _phone;
  dynamic get phoneVerifiedAt => _phoneVerifiedAt;
  dynamic get type => _type;
  dynamic get chanel => _chanel;
  dynamic get imageUrl => _imageUrl;

  User({
      dynamic id,
      dynamic firstName,
      dynamic lastName,
      dynamic username,
      dynamic phone,
      dynamic phoneVerifiedAt,
      dynamic type,
      dynamic chanel,
      dynamic imageUrl}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _username = username;
    _phone = phone;
    _phoneVerifiedAt = phoneVerifiedAt;
    _type = type;
    _chanel = chanel;
    _imageUrl = imageUrl;
}

  User.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _username = json["username"];
    _phone = json["phone"];
    _phoneVerifiedAt = json["phone_verified_at"];
    _type = json["type"];
    _chanel = json["chanel"];
    _imageUrl = json["image_url"];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["username"] = _username;
    map["phone"] = _phone;
    map["phone_verified_at"] = _phoneVerifiedAt;
    map["type"] = _type;
    map["chanel"] = _chanel;
    map["image_url"] = _imageUrl;
    return map;
  }

}

class Products {
  dynamic _id;
  dynamic _name;
  dynamic _description;
  dynamic _shortDescription;
  dynamic _stockQuantity;
  dynamic _regularPrice;
  dynamic _salePrice;
  dynamic _saleStartAt;
  dynamic _saleEndAt;
  dynamic _stockStatus;
  dynamic _status;
  dynamic _totalReviews;
  dynamic _totalRates;
  dynamic _categoryId;
  dynamic _imageId;
  dynamic _offerImageId;
  dynamic _vendorId;
  dynamic _storeType;
  dynamic _storeId;
  dynamic _hotOffer;
  dynamic _deletedAt;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _imageUrl;

  dynamic get id => _id;
  dynamic get name => _name;
  dynamic get description => _description;
  dynamic get shortDescription => _shortDescription;
  dynamic get stockQuantity => _stockQuantity;
  dynamic get regularPrice => _regularPrice;
  dynamic get salePrice => _salePrice;
  dynamic get saleStartAt => _saleStartAt;
  dynamic get saleEndAt => _saleEndAt;
  dynamic get stockStatus => _stockStatus;
  dynamic get status => _status;
  dynamic get totalReviews => _totalReviews;
  dynamic get totalRates => _totalRates;
  dynamic get categoryId => _categoryId;
  dynamic get imageId => _imageId;
  dynamic get offerImageId => _offerImageId;
  dynamic get vendorId => _vendorId;
  dynamic get storeType => _storeType;
  dynamic get storeId => _storeId;
  dynamic get hotOffer => _hotOffer;
  dynamic get deletedAt => _deletedAt;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get imageUrl => _imageUrl;

  Products({
      dynamic id,
      dynamic name,
      dynamic description,
      dynamic shortDescription,
      dynamic stockQuantity,
      dynamic regularPrice,
      dynamic salePrice,
      dynamic saleStartAt,
      dynamic saleEndAt,
      dynamic stockStatus,
      dynamic status,
      dynamic totalReviews,
      dynamic totalRates,
      dynamic categoryId,
      dynamic imageId,
      dynamic offerImageId,
      dynamic vendorId,
      dynamic storeType,
      dynamic storeId,
      dynamic hotOffer,
      dynamic deletedAt,
      dynamic createdAt,
      dynamic updatedAt,
      dynamic imageUrl}){
    _id = id;
    _name = name;
    _description = description;
    _shortDescription = shortDescription;
    _stockQuantity = stockQuantity;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _saleStartAt = saleStartAt;
    _saleEndAt = saleEndAt;
    _stockStatus = stockStatus;
    _status = status;
    _totalReviews = totalReviews;
    _totalRates = totalRates;
    _categoryId = categoryId;
    _imageId = imageId;
    _offerImageId = offerImageId;
    _vendorId = vendorId;
    _storeType = storeType;
    _storeId = storeId;
    _hotOffer = hotOffer;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
}

  Products.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _shortDescription = json["short_description"];
    _stockQuantity = json["stock_quantity"];
    _regularPrice = json["regular_price"];
    _salePrice = json["sale_price"];
    _saleStartAt = json["sale_start_at"];
    _saleEndAt = json["sale_end_at"];
    _stockStatus = json["stock_status"];
    _status = json["status"];
    _totalReviews = json["total_reviews"];
    _totalRates = json["total_rates"];
    _categoryId = json["category_id"];
    _imageId = json["image_id"];
    _offerImageId = json["offer_image_id"];
    _vendorId = json["vendor_id"];
    _storeType = json["store_type"];
    _storeId = json["store_id"];
    _hotOffer = json["hot_offer"];
    _deletedAt = json["deleted_at"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _imageUrl = json["image_url"];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["short_description"] = _shortDescription;
    map["stock_quantity"] = _stockQuantity;
    map["regular_price"] = _regularPrice;
    map["sale_price"] = _salePrice;
    map["sale_start_at"] = _saleStartAt;
    map["sale_end_at"] = _saleEndAt;
    map["stock_status"] = _stockStatus;
    map["status"] = _status;
    map["total_reviews"] = _totalReviews;
    map["total_rates"] = _totalRates;
    map["category_id"] = _categoryId;
    map["image_id"] = _imageId;
    map["offer_image_id"] = _offerImageId;
    map["vendor_id"] = _vendorId;
    map["store_type"] = _storeType;
    map["store_id"] = _storeId;
    map["hot_offer"] = _hotOffer;
    map["deleted_at"] = _deletedAt;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["image_url"] = _imageUrl;
    return map;
  }

}