
class CommonBean {
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
  int doctorId;
  dynamic imageId;
  int categoryId;
  String commercialName;
  int homeVisit;
  String degree;
  String shortDescription;
  String description;
  String website;
  String email;
  dynamic city;
  dynamic governorate;
  dynamic country;
  int totalReviews;
  int totalRates;
  String status;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String imageUrl;
  String speciality;
  List<Medical_servicesBean> medicalServices;
  List<RatesBean> rates;
  String address;

  static CommonBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommonBean doctorBean = CommonBean();
    doctorBean.id = map['id'];
    doctorBean.firstName = map['first_name'];
    doctorBean.lastName = map['last_name'];
    doctorBean.username = map['username'];
    doctorBean.phone = map['phone'];
    doctorBean.verificationCode = map['verification_code'];
    doctorBean.apiToken = map['api_token'];
    doctorBean.phoneVerifiedAt = map['phone_verified_at'];
    doctorBean.type = map['type'];
    doctorBean.chanel = map['chanel'];
    doctorBean.doctorId = map['doctor_id'];
    doctorBean.imageId = map['image_id'];
    doctorBean.categoryId = map['category_id'];
    doctorBean.commercialName = map['commercial_name'];
    doctorBean.homeVisit = map['home_visit'];
    doctorBean.degree = map['degree'];
    doctorBean.shortDescription = map['short_description'];
    doctorBean.description = map['description'];
    doctorBean.website = map['website'];
    doctorBean.email = map['email'];
    doctorBean.city = map['city'];
    doctorBean.governorate = map['governorate'];
    doctorBean.country = map['country'];
    doctorBean.totalReviews = map['total_reviews'];
    doctorBean.totalRates = map['total_rates'];
    doctorBean.status = map['status'];
    doctorBean.createdAt = map['created_at'];
    doctorBean.updatedAt = map['updated_at'];
    doctorBean.deletedAt = map['deleted_at'];
    doctorBean.imageUrl = map['image_url'];
    doctorBean.speciality = map['speciality'];
    doctorBean.medicalServices = List()..addAll(
      (map['medical_services'] as List ?? []).map((o) => Medical_servicesBean.fromMap(o))
    );
    doctorBean.rates = List()..addAll(
      (map['rates'] as List ?? []).map((o) => RatesBean.fromMap(o))
    );
    doctorBean.address = doctorBean.country.toString() +" , "+doctorBean.governorate.toString()+" , "+doctorBean.city.toString();
    return doctorBean;
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


class Medical_servicesBean {
  int id;
  String title;
  int doctorId;
  int parentId;
  int country;
  int governorate;
  int city;
  String address;
  dynamic categoryId;
  dynamic coverImageId;
  dynamic logoId;
  dynamic longitude;
  dynamic latitude;
  dynamic email;
  dynamic website;
  dynamic description;
  int totalReviews;
  int totalRates;
  String type;
  int regularPrice;
  int urgentPrice;
  String phone;
  dynamic limit;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
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