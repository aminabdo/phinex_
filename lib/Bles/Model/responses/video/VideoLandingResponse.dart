class VideoLandingResponse {
  List<Video> videos;
  dynamic message;
  int code;

  static VideoLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VideoLandingResponse videoLandingResponseBean = VideoLandingResponse();
    videoLandingResponseBean.videos = List()..addAll(
      (map['data'] as List ?? []).map((o) => Video.fromMap(o))
    );
    videoLandingResponseBean.message = map['message'];
    videoLandingResponseBean.code = map['code'];
    return videoLandingResponseBean;
  }

  Map toJson() => {
    "data": videos,
    "message": message,
    "code": code,
  };
}

class Video {
  int id;
  int userId;
  String status;
  String title;
  String description;
  int views;
  num duration;
  String path;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  UserBean user;
  int commentsCount;

  static Video fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Video dataBean = Video();
    dataBean.id = map['id'];
    dataBean.userId = map['user_id'];
    dataBean.status = map['status'];
    dataBean.title = map['title'];
    dataBean.description = map['description'];
    dataBean.views = map['views'];
    dataBean.duration = (map['duration'] as num);
    dataBean.path = map['path'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.user = UserBean.fromMap(map['user']);
    dataBean.commentsCount = map['comments_count'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "status": status,
    "title": title,
    "description": description,
    "views": views,
    "duration": duration,
    "path": path,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user,
    "comments_count": commentsCount,
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
  String phoneVerifiedAt;
  String type;
  String chanel;
  DetailsBean details;

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
    userBean.details = DetailsBean.fromMap(map['details']);
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
    "details": details,
  };
}


class DetailsBean {
  int userId;
  dynamic imageId;
  dynamic email;
  dynamic country;
  dynamic governorate;
  dynamic city;
  dynamic address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  dynamic coverImageId;
  dynamic education;
  dynamic jobTitle;
  dynamic description;
  dynamic imageUrl;

  static DetailsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DetailsBean detailsBean = DetailsBean();
    detailsBean.userId = map['user_id'];
    detailsBean.imageId = map['image_id'];
    detailsBean.email = map['email'];
    detailsBean.country = map['country'];
    detailsBean.governorate = map['governorate'];
    detailsBean.city = map['city'];
    detailsBean.address = map['address'];
    detailsBean.addressLatitude = map['address_latitude'];
    detailsBean.addressLongitude = map['address_longitude'];
    detailsBean.deletedAt = map['deleted_at'];
    detailsBean.createdAt = map['created_at'];
    detailsBean.updatedAt = map['updated_at'];
    detailsBean.coverImageId = map['cover_image_id'];
    detailsBean.education = map['education'];
    detailsBean.jobTitle = map['job_title'];
    detailsBean.description = map['description'];
    detailsBean.imageUrl = map['image_url'];
    return detailsBean;
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
  };
}