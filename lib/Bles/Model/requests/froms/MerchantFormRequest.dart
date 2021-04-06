import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class MerchantFormRequest extends BaseRequest{
  List<LangMerchant> langs;
  String firstName;
  String lastName;
  String phone;
  String password;
  String address;
  File image;
  File coverImage;
  dynamic categoryId;
  int contactNumber;
  String email;
  String website;
  dynamic city;
  dynamic governorate;
  double addressLatitude;
  double addressLongitude;
  String openFromTime;
  String openToTime;
  int hotline;
  String deliveryStatus;


  Map toJson() {
    Map map = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "password": password,
      "address": address,
      "image": imageToString(image),
      "cover_image": imageToString(coverImage),
      "category_id": categoryId,
      "contact_number": contactNumber,
      "email": email,
      "website": website,
      "city": city,
      "governorate": governorate,
      "address_latitude": addressLatitude,
      "address_longitude": addressLongitude,
      "open_from_time": openFromTime,
      "open_to_time": openToTime,
      "hotline": hotline,
      "delivery_status": deliveryStatus,
    };
    map.addAll(listToLangMap(langs));
    return map ;
  }

  Map listToLangMap(List<LangMerchant> langs){

    Map<String,LangMerchant> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang:element});
    });

    return map ;
  }
}

class LangMerchant {
  String lang ;
  String commercialName;
  String description;

  LangMerchant({this.lang, this.commercialName, this.description});

  static LangMerchant fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangMerchant enBean = LangMerchant();
    enBean.commercialName = map['commercial_name'];
    enBean.description = map['description'];
    return enBean;
  }

  Map toJson() => {
    "commercial_name": commercialName,
    "description": description,
  };
}