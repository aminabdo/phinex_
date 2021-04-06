class CatalogueSingleResponse {
  DataBean data;
  dynamic message;
  int code;

  static CatalogueSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CatalogueSingleResponse catalogueSingleResponseBean = CatalogueSingleResponse();
    catalogueSingleResponseBean.data = DataBean.fromMap(map['data']);
    catalogueSingleResponseBean.message = map['message'];
    catalogueSingleResponseBean.code = map['code'];
    return catalogueSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  Catalogue catalogue;
  List<Rate> rates;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.catalogue = Catalogue.fromMap(map['catalogue']);
    dataBean.rates = List()..addAll(
      (map['rates'] as List ?? []).map((o) => Rate.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "catalogue": catalogue,
    "rates": rates,
  };
}

class Rate {
  int id;
  int rate;
  String comment;
  int userId;
  int objectId;
  dynamic categoryId;
  String objectName;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  User user;

  static Rate fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Rate ratesBean = Rate();
    ratesBean.id = map['id'];
    ratesBean.rate = map['rate'];
    ratesBean.comment = map['comment'];
    ratesBean.userId = map['user_id'];
    ratesBean.objectId = map['object_id'];
    ratesBean.categoryId = map['category_id'];
    ratesBean.objectName = map['object_name'];
    ratesBean.createdAt = map['created_at'];
    ratesBean.updatedAt = map['updated_at'];
    ratesBean.deletedAt = map['deleted_at'];
    ratesBean.user = User.fromMap(map['user']);
    return ratesBean;
  }

  Map toJson() => {
    "id": id,
    "rate": rate,
    "comment": comment,
    "user_id": userId,
    "object_id": objectId,
    "category_id": categoryId,
    "object_name": objectName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "user": user,
  };
}

class User {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  String phoneVerifiedAt;
  String type;
  String chanel;
  String imageUrl;

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User userBean = User();
    userBean.id = map['id'];
    userBean.firstName = map['first_name'];
    userBean.lastName = map['last_name'];
    userBean.username = map['username'];
    userBean.phone = map['phone'];
    userBean.verificationCode = map['verification_code'];
    userBean.apiToken = map['api_token'];
    userBean.phoneVerifiedAt = map['phone_verified_at'];
    userBean.type = map['type'];
    userBean.chanel = map['chanel'];
    userBean.imageUrl = map['image_url'];
    return userBean;
  }

  Map toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "phone": phone,
    "verification_code": verificationCode,
    "api_token": apiToken,
    "phone_verified_at": phoneVerifiedAt,
    "type": type,
    "chanel": chanel,
    "image_url": imageUrl,
  };
}

class Catalogue {
  int id;
  int categoryId;
  String title;
  String description;
  String businessActivity;
  dynamic businessDescription;
  int country;
  int governorate;
  int city;
  String address;
  dynamic long;
  dynamic lat;
  String email;
  String phone;
  int imageId;
  String website;
  int totalRates;
  String totalReviews;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;
  List<String> gallery;

  static Catalogue fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Catalogue catalogueBean = Catalogue();
    catalogueBean.id = map['id'];
    catalogueBean.categoryId = map['category_id'];
    catalogueBean.title = map['title'];
    catalogueBean.description = map['description'];
    catalogueBean.businessActivity = map['business_activity'];
    catalogueBean.businessDescription = map['business_description'];
    catalogueBean.country = map['country'];
    catalogueBean.governorate = map['governorate'];
    catalogueBean.city = map['city'];
    catalogueBean.address = map['address'];
    catalogueBean.long = map['long'];
    catalogueBean.lat = map['lat'];
    catalogueBean.email = map['email'];
    catalogueBean.phone = map['phone'];
    catalogueBean.imageId = map['image_id'];
    catalogueBean.website = map['website'];
    catalogueBean.totalRates = map['total_rates'];
    catalogueBean.totalReviews = map['total_reviews'];
    catalogueBean.createdAt = map['created_at'];
    catalogueBean.updatedAt = map['updated_at'];
    catalogueBean.deletedAt = map['deleted_at'];
    catalogueBean.imageUrl = map['image_url'];
    catalogueBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
    return catalogueBean;
  }

  Map toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "description": description,
    "business_activity": businessActivity,
    "business_description": businessDescription,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "long": long,
    "lat": lat,
    "email": email,
    "phone": phone,
    "image_id": imageId,
    "website": website,
    "total_rates": totalRates,
    "total_reviews": totalReviews,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "image_url": imageUrl,
    "gallery": gallery,
  };
}