import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class RealStateFormRequest extends BaseRequest {
  String firstName;
  String lastName;
  String phone;
  String password;
  List<LangRealState> langs;
  File image;
  String email;
  String website;
  int contactPerson;
  int contactNumber;
  int governorate;
  int city;
  String address;
  int hotline;
  double addressLatitude;
  double addressLongitude;

  RealStateFormRequest(
      {this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.langs,
      this.image,
      this.email,
      this.website,
      this.contactPerson,
      this.contactNumber,
      this.governorate,
      this.city,
      this.address,
      this.hotline,
      this.addressLatitude,
  });

  Map toJson() {
    Map map = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "password": password,
      "image": imageToString(image),
      "email": email,
      "website": website,
      "contact_person": contactPerson,
      "contact_number": contactNumber,
      "governorate": governorate,
      "city": city,
      "address": address,
      "hotline": hotline,
      "address_latitude": addressLatitude,
      "address_longitude": addressLongitude,
    };
    map.addAll(listToLangMap(langs));
    return map ;
  }


  Map listToLangMap(List<LangRealState> langs){

    Map<String,LangRealState> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang:element});
    });

    return map ;
  }
}

class LangRealState {
  String lang ;
  String commercialName;
  String description;

  LangRealState({this.lang, this.commercialName, this.description});

  Map toJson() => {
    "lang": lang,
    "commercial_name": commercialName,
    "description": description,
  };
}