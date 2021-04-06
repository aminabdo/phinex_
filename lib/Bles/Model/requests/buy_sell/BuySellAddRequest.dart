
import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class BuySellAddRequest extends BaseRequest {
  String title;
  String description;
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

  BuySellAddRequest({this.title,
    this.description,
    this.categoryId,
    this.price,
    this.sellerId,
    this.phone,
    this.status,
    this.city,
    this.governorate,
    this.country,
    this.main_image,
    this.gallery});

  static BuySellAddRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellAddRequest buySellAddRequestBean = BuySellAddRequest();
    buySellAddRequestBean.title = map['title'];
    buySellAddRequestBean.description = map['description'];
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

  Map toJson() =>
      {
        "title": title,
        "description": description,
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

}
