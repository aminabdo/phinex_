import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class BuySellFormRequest extends BaseRequest{
  String categoryId;
  String price;
  String sellerId;
  String phone;
  String status;
  String city;
  String governorate;
  String country;
  File main_image;
  List<File> gallery;
  List<LangBuySellBean> langs;

  BuySellFormRequest({
    this.categoryId,
    this.price,
    this.sellerId,
    this.phone,
    this.status,
    this.city,
    this.governorate,
    this.country,
    this.main_image,
    this.gallery,
    this.langs,
  });

  static BuySellFormRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellFormRequest buySellAddRequestBean = BuySellFormRequest();
    buySellAddRequestBean.categoryId = map['category_id'];
    buySellAddRequestBean.price = map['price'];
    buySellAddRequestBean.sellerId = map['seller_id'];
    buySellAddRequestBean.phone = map['phone'];
    buySellAddRequestBean.status = map['status'];
    buySellAddRequestBean.city = map['city'];
    buySellAddRequestBean.governorate = map['governorate'];
    buySellAddRequestBean.country = map['country'];
    buySellAddRequestBean.main_image = map['main_image'];
    return buySellAddRequestBean;
  }

  Map toJson() {
    Map map = {
      "category_id": categoryId,
      "price": price,
      "seller_id": sellerId,
      "phone": phone,
      "status": status,
      "city": city,
      "governorate": governorate,
      "country": country,
      "main_image": imageToString(this.main_image),
      "gallery": galleryToString(this.gallery),
    };

    map.addAll(listToLangMap(langs));

    return map ;
  }


  Map listToLangMap(List<LangBuySellBean> langs){

    Map<String,LangBuySellBean> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang:element});
    });

    return map ;
  }

  @override
  String toString() {
    return 'BuySellFormRequest{categoryId: $categoryId, price: $price, sellerId: $sellerId, phone: $phone, status: $status, city: $city, governorate: $governorate, country: $country, langs: ${langs[0].toJson()}';
  }
}



class LangBuySellBean {
  String title;
  String description;
  String address;
  String lang ;


  LangBuySellBean({this.title, this.description, this.address, this.lang});

  Map toJson() => {
    "title": title,
    "description": description,
    "address": address,
    "lang" : lang,
  };
}
