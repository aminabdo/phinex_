
class Pharmacy {
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
  dynamic phone;
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
  String description;
  String website;
  String email;
  List<String> gallery;


  static Pharmacy fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Pharmacy pharmaciesBean = Pharmacy();
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
    pharmaciesBean.description = map['description'];
    pharmaciesBean.website = map['website'];
    pharmaciesBean.email = map['email'];
    pharmaciesBean.gallery = List()..addAll(
        (map['gallery'] as List ?? []).map((o) => o.toString())
    );
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
    "description": description,
    "website": website,
    "email": email,
  };
}