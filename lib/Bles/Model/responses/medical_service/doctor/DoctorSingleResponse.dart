/// data : {"id":34,"first_name":"ali","last_name":"hussein","username":"ali hussein","phone":"01234567895","verification_code":"675369","api_token":"fdc8cbcf95cf27f50559eedcaa715a01","phone_verified_at":null,"type":"doctor","chanel":"web","doctor_id":1,"image_id":1694,"category_id":18,"commercial_name":"ali hussein","home_visit":1,"degree":"consultant","short_description":"short desc","description":"desc","website":null,"email":null,"city":"Eshkashem","governorate":"Badakhshan","country":"Afghanistan","total_reviews":5,"total_rates":3,"status":"published","created_at":"2020-09-14 12:06:39","updated_at":"2020-10-29 13:09:41","deleted_at":null,"image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/14-Mon/ali_hussein.jpeg","speciality":"Dentist ","medical_services":[{"id":2,"title":"test","doctor_id":34,"parent_id":0,"country":1,"governorate":42,"city":5909,"address":"test address","category_id":null,"cover_image_id":null,"logo_id":null,"longitude":null,"latitude":null,"email":null,"website":null,"description":null,"total_reviews":0,"total_rates":0,"type":"hospital","regular_price":25,"urgent_price":200,"phone":"0123456789","limit":null,"saturday":1,"sunday":0,"monday":1,"tuesday":0,"wednesday":0,"thursday":0,"friday":0,"open_at":"23:59:00","closing_at":"23:00:00"},{"id":47,"title":"Vision Care","doctor_id":34,"parent_id":0,"country":64,"governorate":1048,"city":15420,"address":"faisal","category_id":18,"cover_image_id":null,"logo_id":null,"longitude":null,"latitude":null,"email":"ali@gmail.com","website":"https://ali.net","description":null,"total_reviews":0,"total_rates":0,"type":"clinic","regular_price":500,"urgent_price":600,"phone":"01266541654","limit":null,"saturday":1,"sunday":1,"monday":0,"tuesday":0,"wednesday":0,"thursday":0,"friday":0,"open_at":"00:00:00","closing_at":"03:00:00"}],"rates":[{"id":39,"rate":5,"comment":"good","user_id":101,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-10-29 13:09:41","updated_at":"2020-10-29 13:09:41","deleted_at":null,"user":{"id":101,"first_name":"Shiref","last_name":"Abouzaid","username":"shiref abouzaid","phone":"69","verification_code":"345244","api_token":"1214b2a3c39f08b2b5544fb5827a1de1","phone_verified_at":null,"type":"user","chanel":"web","image_url":null}},{"id":32,"rate":1,"comment":"sssss","user_id":3,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-23 11:15:24","updated_at":"2020-09-23 11:15:24","deleted_at":null,"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","image_url":null}},{"id":31,"rate":1,"comment":"asasasas","user_id":3,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-23 11:15:03","updated_at":"2020-09-23 11:15:03","deleted_at":null,"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","image_url":null}},{"id":30,"rate":5,"comment":"lololol","user_id":3,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-23 10:35:40","updated_at":"2020-09-23 10:35:40","deleted_at":null,"user":{"id":3,"first_name":"ahmednegm","last_name":"ahmednegm","username":"ossama ossama","phone":"012345678933","verification_code":"767590","api_token":"913d779a8b7b12ee95fe16e86a4c9244","phone_verified_at":null,"type":"driver","chanel":"mobile","image_url":null}},{"id":29,"rate":2,"comment":"hi","user_id":45,"object_id":34,"category_id":null,"object_name":"doctor","created_at":"2020-09-22 21:24:15","updated_at":"2020-09-22 21:24:15","deleted_at":null,"user":{"id":45,"first_name":"Mohamed","last_name":"Safwat","username":"mohamed safwat","phone":"01020155900","verification_code":"600187","api_token":"ef9f2ac4029161d455cffa4536a1ed7f","phone_verified_at":null,"type":"user","chanel":"mobile","image_url":"https://images.tbdm.net/storage/app/public/images/2020-09/22-Tue/mohamed.png"}}]}

class DoctorSingleResponse {
  DataBean data;

  static DoctorSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorSingleResponse doctorSingleResponseBean = DoctorSingleResponse();
    doctorSingleResponseBean.data = DataBean.fromMap(map['data']);
    return doctorSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
  };
}

class DataBean {
  dynamic id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  dynamic doctorId;
  dynamic imageId;
  dynamic categoryId;
  String commercialName;
  dynamic homeVisit;
  String degree;
  String shortDescription;
  String description;
  dynamic website;
  dynamic email;
  String city;
  String governorate;
  String country;
  dynamic totalReviews;
  dynamic totalRates;
  String status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;
  String speciality;
  List<Medical_servicesBean> medicalServices;
  List<RatesBean> rates;


  DataBean(
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
      this.doctorId,
      this.imageId,
      this.categoryId,
      this.commercialName,
      this.homeVisit,
      this.degree,
      this.shortDescription,
      this.description,
      this.website,
      this.email,
      this.city,
      this.governorate,
      this.country,
      this.totalReviews,
      this.totalRates,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.imageUrl,
      this.speciality,
      this.medicalServices,
      this.rates});

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
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
    dataBean.doctorId = map['doctor_id'];
    //dataBean.imageId = map['image_id'];
    dataBean.categoryId = map['category_id'];
    dataBean.commercialName = map['commercial_name'];
    dataBean.homeVisit = map['home_visit'];
    dataBean.degree = map['degree'];
    dataBean.shortDescription = map['short_description'];
    dataBean.description = map['description'];
    dataBean.website = map['website'];
    dataBean.email = map['email'];
    dataBean.city = map['city'];
    dataBean.governorate = map['governorate'];
    dataBean.country = map['country'];
    dataBean.totalReviews = map['total_reviews'];
    dataBean.totalRates = map['total_rates'];
    dataBean.status = map['status'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.imageUrl = map['image_url'];
    dataBean.speciality = map['speciality'];
    dataBean.medicalServices = List()..addAll(
      (map['medical_services'] as List ?? []).map((o) => Medical_servicesBean.fromMap(o))
    );
    dataBean.rates = List()..addAll(
      (map['rates'] as List ?? []).map((o) => RatesBean.fromMap(o))
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
    "doctor_id": doctorId,
    "image_id": imageId,
    "category_id": categoryId,
    "commercial_name": commercialName,
    "home_visit": homeVisit,
    "degree": degree,
    "short_description": shortDescription,
    "description": description,
    "website": website,
    "email": email,
    "city": city,
    "governorate": governorate,
    "country": country,
    "total_reviews": totalReviews,
    "total_rates": totalRates,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "image_url": imageUrl,
    "speciality": speciality,
    "medical_services": medicalServices,
    "rates": rates,
  };
}

class RatesBean {
  dynamic id;
  dynamic rate;
  String comment;
  dynamic userId;
  dynamic objectId;
  dynamic categoryId;
  String objectName;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserBean user;


  RatesBean(
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

  static RatesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RatesBean ratesBean = RatesBean();
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
    ratesBean.user = UserBean.fromMap(map['user']);
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


class UserBean {
  dynamic id;
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

class Medical_servicesBean {
  dynamic id;
  String title;
  dynamic doctorId;
  dynamic parentId;
  dynamic country;
  dynamic governorate;
  dynamic city;
  String address;
  dynamic categoryId;
  dynamic coverImageId;
  dynamic logoId;
  dynamic longitude;
  dynamic latitude;
  dynamic email;
  dynamic website;
  dynamic description;
  dynamic totalReviews;
  dynamic totalRates;
  String type;
  dynamic regularPrice;
  dynamic urgentPrice;
  String phone;
  dynamic limit;
  dynamic saturday;
  dynamic sunday;
  dynamic monday;
  dynamic tuesday;
  dynamic wednesday;
  dynamic thursday;
  dynamic friday;
  String openAt;
  String closingAt;

  static Medical_servicesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Medical_servicesBean medical_servicesBean = Medical_servicesBean();
    medical_servicesBean.id = map['id'];
    medical_servicesBean.title = map['title'];
    medical_servicesBean.doctorId = map['doctor_id'];
    medical_servicesBean.parentId = map['parent_id'];
    medical_servicesBean.country = map['country'];
    medical_servicesBean.governorate = map['governorate'];
    medical_servicesBean.city = map['city'];
    medical_servicesBean.address = map['address'];
    medical_servicesBean.categoryId = map['category_id'];
    medical_servicesBean.coverImageId = map['cover_image_id'];
    medical_servicesBean.logoId = map['logo_id'];
    medical_servicesBean.longitude = map['longitude'];
    medical_servicesBean.latitude = map['latitude'];
    medical_servicesBean.email = map['email'];
    medical_servicesBean.website = map['website'];
    medical_servicesBean.description = map['description'];
    medical_servicesBean.totalReviews = map['total_reviews'];
    medical_servicesBean.totalRates = map['total_rates'];
    medical_servicesBean.type = map['type'];
    medical_servicesBean.regularPrice = map['regular_price'];
    medical_servicesBean.urgentPrice = map['urgent_price'];
    medical_servicesBean.phone = map['phone'];
    medical_servicesBean.limit = map['limit'];
    medical_servicesBean.saturday = map['saturday'];
    medical_servicesBean.sunday = map['sunday'];
    medical_servicesBean.monday = map['monday'];
    medical_servicesBean.tuesday = map['tuesday'];
    medical_servicesBean.wednesday = map['wednesday'];
    medical_servicesBean.thursday = map['thursday'];
    medical_servicesBean.friday = map['friday'];
    medical_servicesBean.openAt = map['open_at'];
    medical_servicesBean.closingAt = map['closing_at'];
    return medical_servicesBean;
  }

  Map toJson() => {
    "id": id,
    "title": title,
    "doctor_id": doctorId,
    "parent_id": parentId,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "category_id": categoryId,
    "cover_image_id": coverImageId,
    "logo_id": logoId,
    "longitude": longitude,
    "latitude": latitude,
    "email": email,
    "website": website,
    "description": description,
    "total_reviews": totalReviews,
    "total_rates": totalRates,
    "type": type,
    "regular_price": regularPrice,
    "urgent_price": urgentPrice,
    "phone": phone,
    "limit": limit,
    "saturday": saturday,
    "sunday": sunday,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "open_at": openAt,
    "closing_at": closingAt,
  };
}