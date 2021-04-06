import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class PharmaCistFormRequest extends BaseRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  String address;
  int city;
  int governorate;
  String commercialName;
  String description;
  String shortDescription;
  File profileImage;
  List<PharmaciesBean> pharmacies;

  Map toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "password": password,
    "address": address,
    "city": city,
    "governorate": governorate,
    "commercial_name": commercialName,
    "description": description,
    "short_description": shortDescription,
    "profile_image": imageToString(profileImage),
    "pharmacies": pharmacies,
  };
}

class PharmaciesBean {
  List<LangPharmacist> langs;
  int country;
  int governorate;
  int city;
  String longitude;
  String latitude;
  int phone;
  int homeVisit;
  String deliveryStatus;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openAt;
  String closingAt;
  String email;
  String website;
  File logoImage;
  File coverImage;
  List<File> gallery;

  Map toJson() {
    Map map = {
      "country": country,
      "governorate": governorate,
      "city": city,
      "longitude": longitude,
      "latitude": latitude,
      "phone": phone,
      "home_visit": homeVisit,
      "delivery_status": deliveryStatus,
      "saturday": saturday,
      "sunday": sunday,
      "monday": monday,
      "tuesday": tuesday,
      "wednesday": wednesday,
      "thursday": thursday,
      "friday": friday,
      "open_at": openAt,
      "closing_at": closingAt,
      "email": email,
      "website": website,
      "logo_image": imageToString(logoImage),
      "cover_image": imageToString(coverImage),
      "gallery": galleryToString(gallery),
    };

    map.addAll(listToLangMap(langs));
    return map ;
  }

    Map listToLangMap(List<LangPharmacist> langs){

      Map<String,LangPharmacist> map = Map();
      langs.forEach((element) {
        map.addAll({element.lang:element});
      });

      return map ;
    }

}

class LangPharmacist {
  String lang;
  String title;
  String address;
  String description;


  LangPharmacist({this.lang, this.title, this.address, this.description});

  static LangPharmacist fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangPharmacist enBean = LangPharmacist();
    enBean.title = map['title'];
    enBean.address = map['address'];
    enBean.description = map['description'];
    return enBean;
  }

  Map toJson() => {
    "title": title,
    "address": address,
    "description": description,
  };
}