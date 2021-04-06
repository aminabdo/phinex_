/// rate : [{"id":39,"rate":5,"comment":"good","user_id":101,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-10-29 13:09:41","updated_at":"2020-10-29 13:09:41","deleted_at":null,"user":{"id":101,"first_name":"Shiref","last_name":"Abouzaid","username":"shiref abouzaid","phone":"69","verification_code":"345244","api_token":"1214b2a3c39f08b2b5544fb5827a1de1","phone_verified_at":null,"type":"user","chanel":"web","image_url":null}},{"id":32,"rate":1,"comment":"sssss","user_id":3,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-23 11:15:24","updated_at":"2020-09-23 11:15:24","deleted_at":null,"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","image_url":null}},{"id":31,"rate":1,"comment":"asasasas","user_id":3,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-23 11:15:03","updated_at":"2020-09-23 11:15:03","deleted_at":null,"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","image_url":null}}]
/// message : null
/// code : 200

class DoctorReviewsResponse {
  List<RateBean> rate;
  dynamic message;
  int code;

  static DoctorReviewsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorReviewsResponse doctorReviewsResponseBean = DoctorReviewsResponse();
    doctorReviewsResponseBean.rate = List()..addAll(
      (map['rate'] as List ?? []).map((o) => RateBean.fromMap(o))
    );
    doctorReviewsResponseBean.message = map['message'];
    doctorReviewsResponseBean.code = map['code'];
    return doctorReviewsResponseBean;
  }

  Map toJson() => {
    "rate": rate,
    "message": message,
    "code": code,
  };
}

/// id : 39
/// rate : 5
/// comment : "good"
/// user_id : 101
/// object_id : 34
/// category_id : null
/// object_name : "doctor"
/// created_at : "2020-10-29 13:09:41"
/// updated_at : "2020-10-29 13:09:41"
/// deleted_at : null
/// user : {"id":101,"first_name":"Shiref","last_name":"Abouzaid","username":"shiref abouzaid","phone":"69","verification_code":"345244","api_token":"1214b2a3c39f08b2b5544fb5827a1de1","phone_verified_at":null,"type":"user","chanel":"web","image_url":null}

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

/// id : 101
/// first_name : "Shiref"
/// last_name : "Abouzaid"
/// username : "shiref abouzaid"
/// phone : "69"
/// verification_code : "345244"
/// api_token : "1214b2a3c39f08b2b5544fb5827a1de1"
/// phone_verified_at : null
/// type : "user"
/// chanel : "web"
/// image_url : null

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