
class PharmacyReviewsResponse {
  List<RateBean> rate;
  dynamic message;
  int code;

  static PharmacyReviewsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmacyReviewsResponse pharmacyReviewsResponse = PharmacyReviewsResponse();
    pharmacyReviewsResponse.rate = List()..addAll(
        (map['rate'] as List ?? []).map((o) => RateBean.fromMap(o))
    );
    pharmacyReviewsResponse.message = map['message'];
    pharmacyReviewsResponse.code = map['code'];
    return pharmacyReviewsResponse;
  }

  Map toJson() => {
    "rate": rate,
    "message": message,
    "code": code,
  };
}

class RateBean {
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
  UserBean user;

  static RateBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RateBean rateBean = RateBean();
    rateBean.id = map['id'];
    rateBean.rate = map['rate'];
    rateBean.comment = map['comment'];
    rateBean.userId = map['user_id'];
    rateBean.objectId = map['object_id'];
    rateBean.categoryId = map['category_id'];
    rateBean.objectName = map['object_name'];
    rateBean.createdAt = map['created_at'];
    rateBean.updatedAt = map['updated_at'];
    rateBean.deletedAt = map['deleted_at'];
    rateBean.user = UserBean.fromMap(map['user']);
    return rateBean;
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

class UserBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  dynamic imageUrl;

  static UserBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserBean userBean = UserBean();
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