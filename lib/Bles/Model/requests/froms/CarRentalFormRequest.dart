import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class CarRentalFormRequest extends BaseRequest {
  String userId;
  String rentalPeriod;
  String rentalPricePerPeriod;
  String transmission;
  String hasDriver;
  String bodyType;
  String carModelId;
  String manufacturerYear;
  String city;
  String country;
  String governorate;
  String phone;
  File main_image;
  List<File> gallery;
  List<LangCarRentalBean> langs;

  CarRentalFormRequest({
    this.userId,
    this.rentalPeriod,
    this.rentalPricePerPeriod,
    this.transmission,
    this.hasDriver,
    this.bodyType,
    this.carModelId,
    this.manufacturerYear,
    this.city,
    this.country,
    this.governorate,
    this.phone,
    this.main_image,
    this.gallery,
    this.langs,
  });

  static CarRentalFormRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CarRentalFormRequest carRentalCreateRequestBean = CarRentalFormRequest();
    carRentalCreateRequestBean.userId = map['user_id'];
    carRentalCreateRequestBean.rentalPeriod = map['rental_period'];
    carRentalCreateRequestBean.rentalPricePerPeriod =
        map['rental_price_per_period'];
    carRentalCreateRequestBean.transmission = map['transmission'];
    carRentalCreateRequestBean.hasDriver = map['has_driver'];
    carRentalCreateRequestBean.bodyType = map['body_type'];
    carRentalCreateRequestBean.carModelId = map['car_model_id'];
    carRentalCreateRequestBean.manufacturerYear = map['manufacturer_year'];
    carRentalCreateRequestBean.city = map['city'];
    carRentalCreateRequestBean.country = map['country'];
    carRentalCreateRequestBean.governorate = map['governorate'];
    carRentalCreateRequestBean.phone = map['phone'];
    return carRentalCreateRequestBean;
  }

  toJson() {
    Map map =  {
      "user_id": userId,
      "rental_period": rentalPeriod,
      "rental_price_per_period": rentalPricePerPeriod,
      "transmission": transmission,
      "has_driver": hasDriver,
      "body_type": bodyType,
      "car_model_id": carModelId,
      "manufacturer_year": manufacturerYear,
      "city": int.parse(city),
      "country": int.parse(country),
      "governorate": int.parse(governorate),
      "phone": phone,
      "main_image": imageToString(this.main_image),
      "gallery": galleryToString(this.gallery),
    };

    map.addAll(listToLangMap(langs));
    return map ;
  }

  Map listToLangMap(List<LangCarRentalBean> langs) {
    Map<String, LangCarRentalBean> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang: element});
    });

    return map;
  }
}

class LangCarRentalBean {
  String title;
  String description;
  String color;
  String lang;

  LangCarRentalBean({this.title, this.description, this.color, this.lang});

  static LangCarRentalBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangCarRentalBean lang = LangCarRentalBean();
    lang.title = map['title'];
    lang.description = map['description'];
    return lang;
  }

  Map toJson() => {
        "title": title,
        "description": description,
        "color": color,
        "lang": lang,
      };

  @override
  String toString() {
    return 'LangCarRentalBean{title: $title, description: $description, color: $color, lang: $lang}';
  }
}
