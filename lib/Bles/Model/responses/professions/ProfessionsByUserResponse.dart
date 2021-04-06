/// data : {"id":19,"first_name":"ahmed","last_name":"ali","username":"ahmed ali","phone":"01066966515","verification_code":"168909","api_token":"8bca70e6d8bc31e3e79f6ee2efe293bf","phone_verified_at":null,"type":"technician","chanel":"web","category":"Carpenter","user_id":19,"image_id":1414,"category_id":35,"commercial_name":"ahmed ali","short_description":"dd","description":"ddddddddd","city":null,"governorate":null,"country":64,"total_reviews":3,"total_rates":3,"created_at":"2020-09-12 11:14:24","updated_at":"2020-09-28 10:18:35","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/12-Sat/ahmed_ali2020-09-12-11:14:24.png","technician_id":1,"workshops":[{"id":1,"technician_id":19,"title":"works","country":64,"governorate":1048,"city":15420,"address":"123hh","long":null,"lat":null,"phone":"1066966525","description":null,"open_from":"00:00:00","open_to":"00:04:00","created_at":"2020-09-12 11:14:24","updated_at":"2020-12-02 10:55:39","deleted_at":null,"saturday":1,"sunday":1,"monday":1,"tuesday":0,"wednesday":0,"thursday":0,"friday":1}],"rate":[{"id":33,"rate":1,"comment":"zft zy 7ayaty","user_id":1,"object_id":19,"category_id":null,"object_name":"technician","created_at":"2020-09-28 10:18:35","updated_at":"2020-09-28 10:18:35","deleted_at":null,"user":{"id":1,"first_name":"Abdallahaa","last_name":"Yehiass","username":"abdallah yehia","phone":"01062547928","verification_code":"337904","api_token":"5a3f5c6b946693354332356a174ba981","phone_verified_at":"2020-09-09T08:09:51.000000Z","type":"admin","chanel":"web","image_url":null}},{"id":28,"rate":4,"comment":"first rate","user_id":36,"object_id":19,"category_id":null,"object_name":"technician","created_at":"2020-09-15 17:16:56","updated_at":"2020-09-15 17:16:56","deleted_at":null,"user":{"id":36,"first_name":"Mammado","last_name":"HK","username":"mammado hk","phone":"01122215543","verification_code":"714817","api_token":"24b8236ba08163bf32931dbc522d806a","phone_verified_at":"2020-10-19T17:40:55.000000Z","type":"user","chanel":"web","image_url":null}},{"id":17,"rate":2,"comment":"nice","user_id":2,"object_id":19,"category_id":null,"object_name":"technician","created_at":"2020-09-12 11:18:21","updated_at":"2020-09-12 11:18:21","deleted_at":null,"user":{"id":2,"first_name":"Israa","last_name":"Thrwat","username":"israa tharwat","phone":"01066966575","verification_code":"542352","api_token":"31807ade9b460626211c3d5ca362d0f5","phone_verified_at":"2020-09-10T14:25:40.000000Z","type":"user","chanel":"web","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/10-Thu/israa.jpeg"}}]}

class ProfessionsByUserResponse {
  ProfessionBean data;

  static ProfessionsByUserResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionsByUserResponse professionsByUserResponseBean = ProfessionsByUserResponse();
    professionsByUserResponseBean.data = ProfessionBean.fromMap(map['data']);
    return professionsByUserResponseBean;
  }

  Map toJson() => {
    "data": data,
  };
}


class ProfessionBean {
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
  String category;
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
  String imageUrl;
  int technicianId;
  List<WorkshopsBean> workshops;
  List<RateBean> rate;

  static ProfessionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionBean dataBean = ProfessionBean();
    dataBean.id = map['id'];
    dataBean.firstName = map['first_name'];
    dataBean.lastName = map['last_name'];
    dataBean.username = map['username'];
    dataBean.phone = map['phone'];
    dataBean.verificationCode = map['verification_code'];
    dataBean.apiToken = map['api_token'];
    dataBean.phoneVerifiedAt = map['phone_verified_at'];
    dataBean.type = map['type'];
    dataBean.chanel = map['chanel'];
    dataBean.category = map['category'];
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
    dataBean.imageUrl = map['image_url'];
    dataBean.technicianId = map['technician_id'];
    dataBean.workshops = List()..addAll(
      (map['workshops'] as List ?? []).map((o) => WorkshopsBean.fromMap(o))
    );
    dataBean.rate = List()..addAll(
      (map['rate'] as List ?? []).map((o) => RateBean.fromMap(o))
    );
    return dataBean;
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
    "category": category,
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
    "image_url": imageUrl,
    "technician_id": technicianId,
    "workshops": workshops,
    "rate": rate,
  };
}


class RateBean {
  int id;
  dynamic rate;
  String comment;
  int userId;
  int objectId;
  dynamic categoryId;
  String objectName;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserBean user;


  RateBean(
      {this.id,
      this.rate,
      this.comment,
      this.userId,
      this.objectId,
      this.categoryId,
      this.objectName,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.user});

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
  String phoneVerifiedAt;
  String type;
  String chanel;
  dynamic imageUrl;

  UserBean(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.phone,
      this.verificationCode,
      this.apiToken,
      this.phoneVerifiedAt,
      this.type,
      this.chanel,
      this.imageUrl});

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

class WorkshopsBean {
  int id;
  int technicianId;
  String title;
  int country;
  int governorate;
  int city;
  String address;
  dynamic long;
  dynamic lat;
  String phone;
  dynamic description;
  String openFrom;
  String openTo;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;

  static WorkshopsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WorkshopsBean workshopsBean = WorkshopsBean();
    workshopsBean.id = map['id'];
    workshopsBean.technicianId = map['technician_id'];
    workshopsBean.title = map['title'];
    workshopsBean.country = map['country'];
    workshopsBean.governorate = map['governorate'];
    workshopsBean.city = map['city'];
    workshopsBean.address = map['address'];
    workshopsBean.long = map['long'];
    workshopsBean.lat = map['lat'];
    workshopsBean.phone = map['phone'];
    workshopsBean.description = map['description'];
    workshopsBean.openFrom = map['open_from'];
    workshopsBean.openTo = map['open_to'];
    workshopsBean.createdAt = map['created_at'];
    workshopsBean.updatedAt = map['updated_at'];
    workshopsBean.deletedAt = map['deleted_at'];
    workshopsBean.saturday = map['saturday'];
    workshopsBean.sunday = map['sunday'];
    workshopsBean.monday = map['monday'];
    workshopsBean.tuesday = map['tuesday'];
    workshopsBean.wednesday = map['wednesday'];
    workshopsBean.thursday = map['thursday'];
    workshopsBean.friday = map['friday'];
    return workshopsBean;
  }

  Map toJson() => {
    "id": id,
    "technician_id": technicianId,
    "title": title,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "long": long,
    "lat": lat,
    "phone": phone,
    "description": description,
    "open_from": openFrom,
    "open_to": openTo,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "saturday": saturday,
    "sunday": sunday,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
  };
}