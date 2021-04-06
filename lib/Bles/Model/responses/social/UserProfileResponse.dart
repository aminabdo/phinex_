class UserProfileResponse {
  DataBean data;
  dynamic message;
  int code;

  static UserProfileResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserProfileResponse testBean = UserProfileResponse();
    testBean.data = DataBean.fromMap(map['data']);
    testBean.message = map['message'];
    testBean.code = map['code'];
    return testBean;
  }

  Map toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}

class DataBean {
  UserSocial details;
  List<String> gallery;
  String friendshipStatus;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.details = UserSocial.fromMap(map['details']);
    dataBean.friendshipStatus = map['friendship-status'];
    dataBean.gallery = List()..addAll((map['gallery'] as List ?? []).map((o) => o.toString()));
    return dataBean;
  }

  Map toJson() => {
        "details": details,
        "gallery": gallery,
        "friendship-status": friendshipStatus,
      };
}

class UserSocial {
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
  String education;
  String email;
  bool friendStatus;
  String governorate;
  int image_id;
  String image_url;
  String job_title;
  String last_name;

  User_detailsBean userDetails;

  static UserSocial fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserSocial detailsBean = UserSocial();
    detailsBean.id = map['id'];
    detailsBean.education = map['education'];
    detailsBean.email = map['email'];
    detailsBean.friendStatus = map['friendStatus'];
    detailsBean.governorate = map['governorate'];
    detailsBean.id = map['id'];
    detailsBean.image_id = map['image_id'];
    detailsBean.image_url = map['image_url'];
    detailsBean.job_title = map['job_title'];
    detailsBean.last_name = map['last_name'];
    detailsBean.firstName = map['first_name'];
    detailsBean.lastName = map['last_name'];
    detailsBean.username = map['username'];
    detailsBean.phone = map['phone'];
    detailsBean.verificationCode = map['verification_code'];
    detailsBean.apiToken = map['api_token'];
    detailsBean.phoneVerifiedAt = map['phone_verified_at'];
    detailsBean.type = map['type'];
    detailsBean.chanel = map['chanel'];
    detailsBean.userDetails = User_detailsBean.fromMap(map['user_details']);
    return detailsBean;
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
        "user_details": userDetails,

      };
}

class User_detailsBean {
  int userId;
  dynamic imageId;
  String email;
  String country;
  String governorate;
  String city;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  dynamic imageUrl;
  dynamic coverImageId;
  String education;
  String jobTitle;
  String description;
  dynamic coverImageUrl;
  dynamic friendRecordId;

  static User_detailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User_detailsBean user_detailsBean = User_detailsBean();
    user_detailsBean.userId = map['user_id'];
    user_detailsBean.imageId = map['image_id'];
    user_detailsBean.email = map['email'];
    user_detailsBean.country = map['country'];
    user_detailsBean.governorate = map['governorate'];
    user_detailsBean.city = map['city'];
    user_detailsBean.address = map['address'];
    user_detailsBean.addressLatitude = map['address_latitude'];
    user_detailsBean.addressLongitude = map['address_longitude'];
    user_detailsBean.deletedAt = map['deleted_at'];
    user_detailsBean.createdAt = map['created_at'];
    user_detailsBean.updatedAt = map['updated_at'];
    user_detailsBean.coverImageId = map['cover_image_id'];
    user_detailsBean.education = map['education'];
    user_detailsBean.jobTitle = map['job_title'];
    user_detailsBean.description = map['description'];
    user_detailsBean.imageUrl = map['image_url'];
    user_detailsBean.coverImageUrl = map['cover_image_url'];
    user_detailsBean.friendRecordId = map['friend_record_id'];
    return user_detailsBean;
  }

  Map toJson() => {
        "user_id": userId,
        "image_id": imageId,
        "email": email,
        "country": country,
        "governorate": governorate,
        "city": city,
        "address": address,
        "address_latitude": addressLatitude,
        "address_longitude": addressLongitude,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "cover_image_id": coverImageId,
        "education": education,
        "job_title": jobTitle,
        "description": description,
        "image_url": imageUrl,
        "cover_image_url": coverImageUrl,
        "friend_record_id": friendRecordId,
      };
}
