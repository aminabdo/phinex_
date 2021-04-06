
import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class CreateCatalougeFormRequest extends BaseRequest {
  String categoryId;
  String email;
  String phone;
  String country;
  String governorate;
  String city;
  String lat;
  String long;
  File mainImage;
  List<File> gallery;
  List<LangCatalouge> lang;

  CreateCatalougeFormRequest({
    this.categoryId,
    this.email,
    this.phone,
    this.country,
    this.governorate,
    this.city,
    this.lat,
    this.mainImage,
    this.gallery,
    this.lang,
    this.long,
  });

  @override
  String toString() {
    return 'CreateCalalougeFormRequest{categoryId: $categoryId, email: $email, phone: $phone, country: $country, governorate: $governorate, city: $city, lat: $lat, long: $long, lang: $lang}';
  }

  Map toJson() {
    Map map = {
      "category_id": categoryId,
      "email": email,
      "phone": phone,
      "country": int.parse(country),
      "governorate": governorate,
      "city": city,
      "lat": lat,
      "long": long,
      "main_image": imageToString(mainImage),
      "gallery": galleryToString(gallery),
    };

    map.addAll(listToLangMap(lang));
    return map;
  }

  Map listToLangMap(List<LangCatalouge> langs) {
    Map<String, LangCatalouge> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang: element});
    });

    return map;
  }
}

class LangCatalouge {
  String title;
  String description;
  String lang;
  String address;
  String business_activity;
  String business_description;

  LangCatalouge({this.title, this.description, this.lang, this.address, this.business_activity, this.business_description});

  Map toJson() => {
    "title": title,
    "description": description,
    "lang": lang,
    "business_description": this.business_description,
    "address": this.address,
    "business_activity": this.business_activity,
  };

  @override
  String toString() {
    return 'LangCatalouge{title: $title, description: $description, lang: $lang, address: $address, business_activity: $business_activity, business_description: $business_description}';
  }
}
