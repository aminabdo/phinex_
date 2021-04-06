import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class WholeSaleFormRequest extends BaseRequest {
  String sellerId;
  String categoryId;
  String opensFrom;
  String endsAt;
  String incrementValue;
  String openPrice;
  String status;
  List<LangWholeSale> langs;
  String isVip;
  File mainImage;
  List<File> gallery;

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

    map.addAll(listToLangMap(langs));

    return map;
  }

  Map listToLangMap(List<LangWholeSale> langs) {
    Map<String, LangWholeSale> map = Map();
    langs.forEach((element) {
      map.addAll({element.lang: element});
    });

    return map;
  }
}

class LangWholeSale {
  String title;
  String description;
  String lang;

  LangWholeSale({this.title, this.description, this.lang});

  static LangWholeSale fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangWholeSale lang = LangWholeSale();
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
