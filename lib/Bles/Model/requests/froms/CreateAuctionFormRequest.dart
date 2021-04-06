import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class CreateAuctionFormRequest extends BaseRequest {
  String sellerId;
  String categoryId;
  String opensFrom;
  String endsAt;
  String incrementValue;
  String openPrice;
  String status;
  String isVip;
  File mainImage;
  List<File> gallery;
  List<LangAuction> lang;

  CreateAuctionFormRequest({
    this.sellerId,
    this.categoryId,
    this.opensFrom,
    this.endsAt,
    this.incrementValue,
    this.openPrice,
    this.status,
    this.isVip,
    this.mainImage,
    this.gallery,
    this.lang,
  });

  Map toJson() {
    Map map = {
      "seller_id": sellerId,
      "category_id": categoryId,
      "opens_from": opensFrom,
      "ends_at": endsAt,
      "increment_value": incrementValue,
      "open_price": openPrice,
      "status": status,
      "is_vip": isVip,
      "main_image": imageToString(mainImage),
      "gallery": galleryToString(gallery),
    };
    map.addAll(listToLangMap(lang));
    return map;
  }

  Map listToLangMap(List<LangAuction> langs) {
    Map<String, LangAuction> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang: element});
    });

    return map;
  }
}

class LangAuction {
  String title;
  String description;
  String lang;

  LangAuction({this.title, this.description, this.lang});

  static LangAuction fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangAuction lang = LangAuction();
    lang.title = map['title'];
    lang.description = map['description'];
    return lang;
  }

  Map toJson() => {
        "title": title,
        "description": description,
        "lang": lang,
      };
}
