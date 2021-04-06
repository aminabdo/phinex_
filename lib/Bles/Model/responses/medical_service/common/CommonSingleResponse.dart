import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorReviewsResponse.dart';

class CommonSingleResponse {
  CommonBean data;
  String message;
  dynamic code;

  static CommonSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommonSingleResponse commonSingleResponseBean = CommonSingleResponse();
    commonSingleResponseBean.data = CommonBean.fromMap(map['data']);
    commonSingleResponseBean.message = map['message'];
    commonSingleResponseBean.code = map['code'];
    return commonSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

/// id : 39
/// title : "Spa for all"
/// doctor_id : 385
/// parent_id : 0
/// country : 64
/// governorate : 1048
/// city : 15420
/// address : "areesh"
/// category_id : null
/// cover_image_id : null
/// logo_id : null
/// longitude : null
/// latitude : null
/// email : null
/// website : null
/// description : null
/// total_reviews : 0
/// total_rates : 0
/// type : "spa"
/// regular_price : 1231
/// urgent_price : 115
/// phone : "584448"
/// limit : null
/// saturday : 0
/// sunday : 0
/// monday : 0
/// tuesday : 0
/// wednesday : 0
/// thursday : 0
/// friday : 0
/// open_at : "00:00:00"
/// closing_at : "00:00:00"
/// gallery : []
/// rates : []
/// doctor : {"id":62,"doctor_id":385,"image_id":3278,"category_id":18,"commercial_name":"Khaled abn el waleed","home_visit":1,"degree":"professor","short_description":"General clinic","description":"General clinic","website":null,"email":null,"city":15418,"governorate":1048,"country":64,"total_reviews":0,"total_rates":0,"status":"pending","created_at":"2020-12-02 08:06:21","updated_at":"2020-12-02 08:06:21","deleted_at":null,"image_url":"https://images.phinex.net/storage/app/public/images/2020-12/02-Wed/khaled_abn_el_waleed.jpeg"}

class CommonBean {
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


  List<String> gallery;
  List<RateBean> rates;

  DoctorBean doctor;
  String logoUrl;
  String coverImageUrl;

  List<CommonBean> clinics;


  static CommonBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommonBean dataBean = CommonBean();
    dataBean.id = map['id'];
    dataBean.title = map['title'];
    dataBean.doctorId = map['doctor_id'];
    dataBean.parentId = map['parent_id'];
    dataBean.country = map['country'];
    dataBean.governorate = map['governorate'];
    dataBean.city = map['city'];
    dataBean.address = map['address'];
    dataBean.categoryId = map['category_id'];
    dataBean.coverImageId = map['cover_image_id'];
    dataBean.logoId = map['logo_id'];
    dataBean.longitude = map['longitude'];
    dataBean.latitude = map['latitude'];
    dataBean.email = map['email'];
    dataBean.website = map['website'];
    dataBean.description = map['description'];
    dataBean.totalReviews = map['total_reviews'];
    dataBean.totalRates = map['total_rates'];
    dataBean.type = map['type'];
    dataBean.regularPrice = map['regular_price'];
    dataBean.urgentPrice = map['urgent_price'];
    dataBean.phone = map['phone'];
    dataBean.limit = map['limit'];
    dataBean.saturday = map['saturday'];
    dataBean.sunday = map['sunday'];
    dataBean.monday = map['monday'];
    dataBean.tuesday = map['tuesday'];
    dataBean.wednesday = map['wednesday'];
    dataBean.thursday = map['thursday'];
    dataBean.friday = map['friday'];
    dataBean.openAt = map['open_at'];
    dataBean.closingAt = map['closing_at'];
    dataBean.logoUrl = map['logo_url'];
    dataBean.coverImageUrl = map['cover_image_url'];

    dataBean.gallery = List()..addAll(
        (map['gallery'] as List ?? []).map((o) => o.toString())
    );

    dataBean.rates = List()..addAll(
        (map['rates'] as List ?? []).map((o) => RateBean.fromMap(o))
    );
    dataBean.clinics = List()..addAll(
        (map['clinics'] as List ?? []).map((o) => CommonBean.fromMap(o))
    );
    dataBean.doctor = DoctorBean.fromMap(map['doctor']);
    return dataBean;
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
    "gallery": gallery,
    "rates": rates,
    "doctor": doctor,
    "logo_url": logoUrl,
    "cover_image_url": coverImageUrl,
  };
}

/// id : 62
/// doctor_id : 385
/// image_id : 3278
/// category_id : 18
/// commercial_name : "Khaled abn el waleed"
/// home_visit : 1
/// degree : "professor"
/// short_description : "General clinic"
/// description : "General clinic"
/// website : null
/// email : null
/// city : 15418
/// governorate : 1048
/// country : 64
/// total_reviews : 0
/// total_rates : 0
/// status : "pending"
/// created_at : "2020-12-02 08:06:21"
/// updated_at : "2020-12-02 08:06:21"
/// deleted_at : null
/// image_url : "https://images.phinex.net/storage/app/public/images/2020-12/02-Wed/khaled_abn_el_waleed.jpeg"


class DoctorBean {
  dynamic id;
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
  dynamic city;
  dynamic governorate;
  dynamic country;
  dynamic totalReviews;
  dynamic totalRates;
  String status;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String imageUrl;

  static DoctorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorBean doctorBean = DoctorBean();
    doctorBean.id = map['id'];
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
    return doctorBean;
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