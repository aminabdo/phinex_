

class CommonClinic {
  String title;
  int userId;
  int country;
  int governorate;
  int city;
  String address;
  String longitude;
  String latitude;
  int phone;
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

  static CommonClinic fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommonClinic commonClinicBean = CommonClinic();
    commonClinicBean.title = map['title'];
    commonClinicBean.userId = map['user_id'];
    commonClinicBean.country = map['country'];
    commonClinicBean.governorate = map['governorate'];
    commonClinicBean.city = map['city'];
    commonClinicBean.address = map['address'];
    commonClinicBean.longitude = map['longitude'];
    commonClinicBean.latitude = map['latitude'];
    commonClinicBean.phone = map['phone'];
    commonClinicBean.description = map['description'];
    commonClinicBean.website = map['website'];
    commonClinicBean.email = map['email'];
    commonClinicBean.homeVisit = map['home_visit'];
    commonClinicBean.deliveryStatus = map['delivery_status'];
    commonClinicBean.totalReviews = map['total_reviews'];
    commonClinicBean.totalRates = map['total_rates'];
    commonClinicBean.saturday = map['saturday'];
    commonClinicBean.sunday = map['sunday'];
    commonClinicBean.monday = map['monday'];
    commonClinicBean.tuesday = map['tuesday'];
    commonClinicBean.wednesday = map['wednesday'];
    commonClinicBean.thursday = map['thursday'];
    commonClinicBean.friday = map['friday'];
    commonClinicBean.openAt = map['open_at'];
    commonClinicBean.closingAt = map['closing_at'];
    commonClinicBean.pharmacyId = map['pharmacyId'];
    commonClinicBean.logoUrl = map['logo_url'];
    commonClinicBean.coverImageUrl = map['cover_image_url'];
    return commonClinicBean;
  }

  Map toJson() => {
    "title": title,
    "user_id": userId,
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