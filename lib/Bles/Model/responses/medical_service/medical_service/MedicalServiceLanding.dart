class MedicalServiceLanding {
  DataBean data;
  dynamic message;
  int code;

  static MedicalServiceLanding fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MedicalServiceLanding medicalServiceLandingBean = MedicalServiceLanding();
    medicalServiceLandingBean.data = DataBean.fromMap(map['data']);
    medicalServiceLandingBean.message = map['message'];
    medicalServiceLandingBean.code = map['code'];
    return medicalServiceLandingBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<DoctorsBean> doctors;
  List<HospitalsBean> hospitals;
  List<ClinicsBean> clinics;
  List<SpaBean> spa;
  List<LaboratoriesBean> laboratories;
  List<PharmaciesBean> pharmacies;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.doctors = List()..addAll(
      (map['doctors'] as List ?? []).map((o) => DoctorsBean.fromMap(o))
    );
    dataBean.hospitals = List()..addAll(
      (map['hospitals'] as List ?? []).map((o) => HospitalsBean.fromMap(o))
    );
    dataBean.clinics = List()..addAll(
      (map['clinics'] as List ?? []).map((o) => ClinicsBean.fromMap(o))
    );
    dataBean.spa = List()..addAll(
      (map['spa'] as List ?? []).map((o) => SpaBean.fromMap(o))
    );
    dataBean.laboratories = List()..addAll(
      (map['laboratories'] as List ?? []).map((o) => LaboratoriesBean.fromMap(o))
    );
    dataBean.pharmacies = List()..addAll(
      (map['pharmacies'] as List ?? []).map((o) => PharmaciesBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "doctors": doctors,
    "hospitals": hospitals,
    "clinics": clinics,
    "spa": spa,
    "laboratories": laboratories,
    "pharmacies": pharmacies,
  };
}

class PharmaciesBean {
  String title;
  int userId;
  int logoId;
  int coverImageId;
  int country;
  int governorate;
  int city;
  String address;
  String longitude;
  String latitude;
  String phone;
  dynamic description;
  dynamic website;
  dynamic email;
  int homeVisit;
  String deliveryStatus;
  int totalReviews;
  int totalRates;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openAt;
  String closingAt;
  int pharmacyId;
  String logoUrl;
  String coverImageUrl;

  static PharmaciesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmaciesBean pharmaciesBean = PharmaciesBean();
    pharmaciesBean.title = map['title'];
    pharmaciesBean.userId = map['user_id'];
    pharmaciesBean.logoId = map['logo_id'];
    pharmaciesBean.coverImageId = map['cover_image_id'];
    pharmaciesBean.country = map['country'];
    pharmaciesBean.governorate = map['governorate'];
    pharmaciesBean.city = map['city'];
    pharmaciesBean.address = map['address'];
    pharmaciesBean.longitude = map['longitude'];
    pharmaciesBean.latitude = map['latitude'];
    pharmaciesBean.phone = map['phone'];
    pharmaciesBean.description = map['description'];
    pharmaciesBean.website = map['website'];
    pharmaciesBean.email = map['email'];
    pharmaciesBean.homeVisit = map['home_visit'];
    pharmaciesBean.deliveryStatus = map['delivery_status'];
    pharmaciesBean.totalReviews = map['total_reviews'];
    pharmaciesBean.totalRates = map['total_rates'];
    pharmaciesBean.saturday = map['saturday'];
    pharmaciesBean.sunday = map['sunday'];
    pharmaciesBean.monday = map['monday'];
    pharmaciesBean.tuesday = map['tuesday'];
    pharmaciesBean.wednesday = map['wednesday'];
    pharmaciesBean.thursday = map['thursday'];
    pharmaciesBean.friday = map['friday'];
    pharmaciesBean.openAt = map['open_at'];
    pharmaciesBean.closingAt = map['closing_at'];
    pharmaciesBean.pharmacyId = map['pharmacyId'];
    pharmaciesBean.logoUrl = map['logo_url'];
    pharmaciesBean.coverImageUrl = map['cover_image_url'];
    return pharmaciesBean;
  }

  Map toJson() => {
    "title": title,
    "user_id": userId,
    "logo_id": logoId,
    "cover_image_id": coverImageId,
    "country": country,
    "governorate": governorate,
    "city": city,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
    "phone": phone,
    "description": description,
    "website": website,
    "email": email,
    "home_visit": homeVisit,
    "delivery_status": deliveryStatus,
    "total_reviews": totalReviews,
    "total_rates": totalRates,
    "saturday": saturday,
    "sunday": sunday,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thursday": thursday,
    "friday": friday,
    "open_at": openAt,
    "closing_at": closingAt,
    "pharmacyId": pharmacyId,
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

class LaboratoriesBean {
  int id;
  String title;
  int doctorId;
  int parentId;
  int country;
  int governorate;
  int city;
  String address;
  int categoryId;
  int coverImageId;
  int logoId;
  String longitude;
  String latitude;
  String email;
  String website;
  String description;
  int totalReviews;
  int totalRates;
  String type;
  dynamic regularPrice;
  dynamic urgentPrice;
  String phone;
  int limit;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openAt;
  String closingAt;
  String logoUrl;
  String coverImageUrl;

  static LaboratoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LaboratoriesBean laboratoriesBean = LaboratoriesBean();
    laboratoriesBean.id = map['id'];
    laboratoriesBean.title = map['title'];
    laboratoriesBean.doctorId = map['doctor_id'];
    laboratoriesBean.parentId = map['parent_id'];
    laboratoriesBean.country = map['country'];
    laboratoriesBean.governorate = map['governorate'];
    laboratoriesBean.city = map['city'];
    laboratoriesBean.address = map['address'];
    laboratoriesBean.categoryId = map['category_id'];
    laboratoriesBean.coverImageId = map['cover_image_id'];
    laboratoriesBean.logoId = map['logo_id'];
    laboratoriesBean.longitude = map['longitude'];
    laboratoriesBean.latitude = map['latitude'];
    laboratoriesBean.email = map['email'];
    laboratoriesBean.website = map['website'];
    laboratoriesBean.description = map['description'];
    laboratoriesBean.totalReviews = map['total_reviews'];
    laboratoriesBean.totalRates = map['total_rates'];
    laboratoriesBean.type = map['type'];
    laboratoriesBean.regularPrice = num.parse(map['regular_price'].toString());
    laboratoriesBean.urgentPrice = num.parse(map['urgent_price'].toString());
    laboratoriesBean.phone = map['phone'];
    laboratoriesBean.limit = map['limit'];
    laboratoriesBean.saturday = map['saturday'];
    laboratoriesBean.sunday = map['sunday'];
    laboratoriesBean.monday = map['monday'];
    laboratoriesBean.tuesday = map['tuesday'];
    laboratoriesBean.wednesday = map['wednesday'];
    laboratoriesBean.thursday = map['thursday'];
    laboratoriesBean.friday = map['friday'];
    laboratoriesBean.openAt = map['open_at'];
    laboratoriesBean.closingAt = map['closing_at'];
    laboratoriesBean.logoUrl = map['logo_url'];
    laboratoriesBean.coverImageUrl = map['cover_image_url'];
    return laboratoriesBean;
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
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

class SpaBean {
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
  dynamic regularPrice;
  dynamic urgentPrice;
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
  String logoUrl;
  String coverImageUrl;

  static SpaBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SpaBean spaBean = SpaBean();
    spaBean.id = map['id'];
    spaBean.title = map['title'];
    spaBean.doctorId = map['doctor_id'];
    spaBean.parentId = map['parent_id'];
    spaBean.country = map['country'];
    spaBean.governorate = map['governorate'];
    spaBean.city = map['city'];
    spaBean.address = map['address'];
    spaBean.categoryId = map['category_id'];
    spaBean.coverImageId = map['cover_image_id'];
    spaBean.logoId = map['logo_id'];
    spaBean.longitude = map['longitude'];
    spaBean.latitude = map['latitude'];
    spaBean.email = map['email'];
    spaBean.website = map['website'];
    spaBean.description = map['description'];
    spaBean.totalReviews = map['total_reviews'];
    spaBean.totalRates = map['total_rates'];
    spaBean.type = map['type'];
    spaBean.regularPrice = num.parse(map['regular_price'].toString());
    spaBean.urgentPrice = num.parse(map['urgent_price'].toString());
    spaBean.phone = map['phone'];
    spaBean.limit = map['limit'];
    spaBean.saturday = map['saturday'];
    spaBean.sunday = map['sunday'];
    spaBean.monday = map['monday'];
    spaBean.tuesday = map['tuesday'];
    spaBean.wednesday = map['wednesday'];
    spaBean.thursday = map['thursday'];
    spaBean.friday = map['friday'];
    spaBean.openAt = map['open_at'];
    spaBean.closingAt = map['closing_at'];
    spaBean.logoUrl = map['logo_url'];
    spaBean.coverImageUrl = map['cover_image_url'];
    return spaBean;
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
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

class ClinicsBean {
  int id;
  String title;
  int doctorId;
  int parentId;
  int country;
  int governorate;
  int city;
  String address;
  int categoryId;
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
  num regularPrice;
  num urgentPrice;
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
  String logoUrl;
  String coverImageUrl;

  static ClinicsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ClinicsBean clinicsBean = ClinicsBean();
    clinicsBean.id = map['id'];
    clinicsBean.title = map['title'];
    clinicsBean.doctorId = map['doctor_id'];
    clinicsBean.parentId = map['parent_id'];
    clinicsBean.country = map['country'];
    clinicsBean.governorate = map['governorate'];
    clinicsBean.city = map['city'];
    clinicsBean.address = map['address'];
    clinicsBean.categoryId = map['category_id'];
    clinicsBean.coverImageId = map['cover_image_id'];
    clinicsBean.logoId = map['logo_id'];
    clinicsBean.longitude = map['longitude'];
    clinicsBean.latitude = map['latitude'];
    clinicsBean.email = map['email'];
    clinicsBean.website = map['website'];
    clinicsBean.description = map['description'];
    clinicsBean.totalReviews = map['total_reviews'];
    clinicsBean.totalRates = map['total_rates'];
    clinicsBean.type = map['type'];
    clinicsBean.regularPrice = num.parse(map['regular_price'].toString());
    clinicsBean.urgentPrice = num.parse(map['urgent_price'].toString());
    clinicsBean.phone = map['phone'];
    clinicsBean.limit = map['limit'];
    clinicsBean.saturday = map['saturday'];
    clinicsBean.sunday = map['sunday'];
    clinicsBean.monday = map['monday'];
    clinicsBean.tuesday = map['tuesday'];
    clinicsBean.wednesday = map['wednesday'];
    clinicsBean.thursday = map['thursday'];
    clinicsBean.friday = map['friday'];
    clinicsBean.openAt = map['open_at'];
    clinicsBean.closingAt = map['closing_at'];
    clinicsBean.logoUrl = map['logo_url'];
    clinicsBean.coverImageUrl = map['cover_image_url'];
    return clinicsBean;
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
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

class HospitalsBean {
  int id;
  String title;
  int doctorId;
  dynamic parentId;
  int country;
  int governorate;
  int city;
  String address;
  int categoryId;
  int coverImageId;
  int logoId;
  String longitude;
  String latitude;
  String email;
  String website;
  String description;
  int totalReviews;
  int totalRates;
  String type;
  num regularPrice;
  num urgentPrice;
  String phone;
  int limit;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openAt;
  String closingAt;
  String logoUrl;
  String coverImageUrl;

  static HospitalsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    HospitalsBean hospitalsBean = HospitalsBean();
    hospitalsBean.id = map['id'];
    hospitalsBean.title = map['title'];
    hospitalsBean.doctorId = map['doctor_id'];
    hospitalsBean.parentId = map['parent_id'];
    hospitalsBean.country = map['country'];
    hospitalsBean.governorate = map['governorate'];
    hospitalsBean.city = map['city'];
    hospitalsBean.address = map['address'];
    hospitalsBean.categoryId = map['category_id'];
    hospitalsBean.coverImageId = map['cover_image_id'];
    hospitalsBean.logoId = map['logo_id'];
    hospitalsBean.longitude = map['longitude'];
    hospitalsBean.latitude = map['latitude'];
    hospitalsBean.email = map['email'];
    hospitalsBean.website = map['website'];
    hospitalsBean.description = map['description'];
    hospitalsBean.totalReviews = map['total_reviews'];
    hospitalsBean.totalRates = map['total_rates'];
    hospitalsBean.type = map['type'];
    hospitalsBean.regularPrice = num.parse(map['regular_price'].toString());
    hospitalsBean.urgentPrice = num.parse(map['urgent_price'].toString());
    hospitalsBean.phone = map['phone'];
    hospitalsBean.limit = map['limit'];
    hospitalsBean.saturday = map['saturday'];
    hospitalsBean.sunday = map['sunday'];
    hospitalsBean.monday = map['monday'];
    hospitalsBean.tuesday = map['tuesday'];
    hospitalsBean.wednesday = map['wednesday'];
    hospitalsBean.thursday = map['thursday'];
    hospitalsBean.friday = map['friday'];
    hospitalsBean.openAt = map['open_at'];
    hospitalsBean.closingAt = map['closing_at'];
    hospitalsBean.logoUrl = map['logo_url'];
    hospitalsBean.coverImageUrl = map['cover_image_url'];
    return hospitalsBean;
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
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

class DoctorsBean {
  int id;
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
  int city;
  int governorate;
  int country;
  int totalReviews;
  int totalRates;
  String status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;

  static DoctorsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorsBean doctorsBean = DoctorsBean();
    doctorsBean.id = map['id'];
    doctorsBean.doctorId = map['doctor_id'];
    doctorsBean.imageId = map['image_id'];
    doctorsBean.categoryId = map['category_id'];
    doctorsBean.commercialName = map['commercial_name'];
    doctorsBean.homeVisit = map['home_visit'];
    doctorsBean.degree = map['degree'];
    doctorsBean.shortDescription = map['short_description'];
    doctorsBean.description = map['description'];
    doctorsBean.website = map['website'];
    doctorsBean.email = map['email'];
    doctorsBean.city = map['city'];
    doctorsBean.governorate = map['governorate'];
    doctorsBean.country = map['country'];
    doctorsBean.totalReviews = map['total_reviews'];
    doctorsBean.totalRates = map['total_rates'];
    doctorsBean.status = map['status'];
    doctorsBean.createdAt = map['created_at'];
    doctorsBean.updatedAt = map['updated_at'];
    doctorsBean.deletedAt = map['deleted_at'];
    doctorsBean.imageUrl = map['image_url'];
    return doctorsBean;
  }

  Map toJson() => {
    "id": id,
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
  };
}