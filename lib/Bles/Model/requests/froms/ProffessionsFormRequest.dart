import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class ProffessionsFormRequest extends BaseRequest{
  String firstName;
  String lastName;
  String phone;
  String password;
  File image;
  int categoryId;
  int governorate;
  int city;
  List<WorkshopsBean> workshops;
  List<LangProffessionBean> langs;

  ProffessionsFormRequest(
      {this.firstName,
      this.lastName,
      this.phone,
      this.password,
      this.image,
      this.categoryId,
      this.governorate,
      this.city,
      this.workshops,
      this.langs,
      });

  Map toJson() {
    Map map = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "password": password,
      "image": imageToString(image),
      "category_id": categoryId,
      "governorate": governorate,
      "city": city,
      "workshops": workshops,
    };

    map.addAll(listToLangMap(langs));

    return map;
  }


  @override
  String toString() {
    return 'ProffessionsFormRequest{firstName: $firstName, lastName: $lastName, phone: $phone, password: $password, categoryId: $categoryId, governorate: $governorate, city: $city, workshops: $workshops, langs: $langs}';
  }

  Map listToLangMap(List<LangProffessionBean> langs){

    Map<String,LangProffessionBean> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang:element});
    });

    return map ;
  }
}

class WorkshopsBean {
  int governorate;
  int city;
  double long;
  double lat;
  int phone;
  int saturday;
  int sunday;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  String openFrom;
  String openTo;
  List<LangWorkShopBean> langWorkShops;

  WorkshopsBean(
      {
      this.governorate,
      this.city,
      this.long,
      this.lat,
      this.phone,
      this.saturday,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.openFrom,
      this.openTo,
      this.langWorkShops,});

  static WorkshopsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WorkshopsBean workshopsBean = WorkshopsBean();
    workshopsBean.governorate = map['governorate'];
    workshopsBean.city = map['city'];
    workshopsBean.long = map['long'];
    workshopsBean.lat = map['lat'];
    workshopsBean.phone = map['phone'];
    workshopsBean.saturday = map['saturday'];
    workshopsBean.sunday = map['sunday'];
    workshopsBean.monday = map['monday'];
    workshopsBean.tuesday = map['tuesday'];
    workshopsBean.wednesday = map['wednesday'];
    workshopsBean.thursday = map['thursday'];
    workshopsBean.friday = map['friday'];
    workshopsBean.openFrom = map['openFrom'];
    workshopsBean.openTo = map['openTo'];
    return workshopsBean;
  }


  @override
  String toString() {
    return 'WorkshopsBean{governorate: $governorate, city: $city, long: $long, lat: $lat, phone: $phone, saturday: $saturday, sunday: $sunday, monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, openFrom: $openFrom, openTo: $openTo, langWorkShops: $langWorkShops}';
  }

  Map toJson() {
    Map map =  {
      "governorate": governorate,
      "city": city,
      "long": long,
      "lat": lat,
      "phone": phone,
      "saturday": saturday,
      "sunday": sunday,
      "monday": monday,
      "tuesday": tuesday,
      "wednesday": wednesday,
      "thursday": thursday,
      "friday": friday,
      "openFrom": openFrom,
      "openTo":openTo,
    };

    map.addAll(listToLangMap(langWorkShops));

    return map ;
  }

  Map listToLangMap(List<LangWorkShopBean> langs){

    Map<String,LangWorkShopBean> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang:element});
    });

    return map ;
  }
}

class LangProffessionBean {
  String lang;
  String commercial_name;
  String short_description;
  String description;

  LangProffessionBean({this.lang, this.commercial_name, this.short_description, this.description});


  @override
  String toString() {
    return 'LangProffessionBean{lang: $lang, title: $commercial_name, address: $short_description, description: $description}';
  }

  static LangProffessionBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangProffessionBean enBean = LangProffessionBean();
    enBean.commercial_name = map['title'];
    enBean.short_description = map['address'];
    enBean.description = map['description'];
    return enBean;
  }

  Map toJson() => {
    "commercial_name": commercial_name,
    "short_description": short_description,
    "description": description,
  };
}

class LangWorkShopBean {
  String title;
  String address;
  String description;
  String lang;

  LangWorkShopBean({this.title = '', this.address = '', this.description = '', this.lang});

  static LangWorkShopBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangWorkShopBean enBean = LangWorkShopBean();
    enBean.title = map['title'];
    enBean.address = map['address'];
    enBean.description = map['description'];
    return enBean;
  }


  @override
  String toString() {
    return 'LangWorkShopBean{commercialName: $title, shortDescription: $address, description: $description, lang: $lang}';
  }

  Map toJson() => {
    "title": title,
    "address": address,
    "description": description,
  };
}