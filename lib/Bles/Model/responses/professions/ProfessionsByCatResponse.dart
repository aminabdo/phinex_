import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';

/// data : [{"id":19,"user_id":19,"image_id":1414,"category_id":35,"commercial_name":"ahmed ali","short_description":"dd","description":"ddddddddd","city":null,"governorate":null,"country":64,"total_reviews":3,"total_rates":3,"created_at":"2020-09-12 11:14:24","updated_at":"2020-09-28 10:18:35","deleted_at":null,"category":"Carpenter","first_name":"ahmed","last_name":"ali","username":"ahmed ali","phone":"01066966515","verification_code":"168909","api_token":"8bca70e6d8bc31e3e79f6ee2efe293bf","phone_verified_at":null,"type":"technician","chanel":"web","image_url":"https://images.phinex.net/storage/app/public/images/2020-09/12-Sat/ahmed_ali2020-09-12-11:14:24.png"}]
/// message : null
/// code : 200

class ProfessionsByCatResponse {
  List<ProfessionBean> data;
  dynamic message;
  int code;

  static ProfessionsByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionsByCatResponse professionsByCatResponseBean = ProfessionsByCatResponse();
    professionsByCatResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => ProfessionBean.fromMap(o))
    );
    professionsByCatResponseBean.message = map['message'];
    professionsByCatResponseBean.code = map['code'];
    return professionsByCatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  int id;
  int userId;
  int imageId;
  int categoryId;
  String commercialName;
  String shortDescription;
  String description;
  dynamic city;
  dynamic governorate;
  int country;
  int totalReviews;
  int totalRates;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String category;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  String imageUrl;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.userId = map['user_id'];
    dataBean.imageId = map['image_id'];
    dataBean.categoryId = map['category_id'];
    dataBean.commercialName = map['commercial_name'];
    dataBean.shortDescription = map['short_description'];
    dataBean.description = map['description'];
    dataBean.city = map['city'];
    dataBean.governorate = map['governorate'];
    dataBean.country = map['country'];
    dataBean.totalReviews = map['total_reviews'];
    dataBean.totalRates = map['total_rates'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.category = map['category'];
    dataBean.firstName = map['first_name'];
    dataBean.lastName = map['last_name'];
    dataBean.username = map['username'];
    dataBean.phone = map['phone'];
    dataBean.verificationCode = map['verification_code'];
    dataBean.apiToken = map['api_token'];
    dataBean.phoneVerifiedAt = map['phone_verified_at'];
    dataBean.type = map['type'];
    dataBean.chanel = map['chanel'];
    dataBean.imageUrl = map['image_url'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "image_id": imageId,
    "category_id": categoryId,
    "commercial_name": commercialName,
    "short_description": shortDescription,
    "description": description,
    "city": city,
    "governorate": governorate,
    "country": country,
    "total_reviews": totalReviews,
    "total_rates": totalRates,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "category": category,
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