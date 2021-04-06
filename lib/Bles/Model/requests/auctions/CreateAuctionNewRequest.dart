class CreateAuctionNewRequest {
  String sellerId;
  String categoryId;
  String opensFrom;
  String endsAt;
  String incrementValue;
  String openPrice;
  String status;
  ArBean ar;
  EnBean en;
  FrBean fr;
  String isVip;
  String mainImage;
  List<String> gallery;

  static CreateAuctionNewRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CreateAuctionNewRequest createAuctionNewRequestBean = CreateAuctionNewRequest();
    createAuctionNewRequestBean.sellerId = map['seller_id'];
    createAuctionNewRequestBean.categoryId = map['category_id'];
    createAuctionNewRequestBean.opensFrom = map['opens_from'];
    createAuctionNewRequestBean.endsAt = map['ends_at'];
    createAuctionNewRequestBean.incrementValue = map['increment_value'];
    createAuctionNewRequestBean.openPrice = map['open_price'];
    createAuctionNewRequestBean.status = map['status'];
    createAuctionNewRequestBean.ar = ArBean.fromMap(map['ar']);
    createAuctionNewRequestBean.en = EnBean.fromMap(map['en']);
    createAuctionNewRequestBean.fr = FrBean.fromMap(map['fr']);
    createAuctionNewRequestBean.isVip = map['is_vip'];
    createAuctionNewRequestBean.mainImage = map['main_image'];
    createAuctionNewRequestBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
    return createAuctionNewRequestBean;
  }

  Map toJson() => {
    "seller_id": sellerId,
    "category_id": categoryId,
    "opens_from": opensFrom,
    "ends_at": endsAt,
    "increment_value": incrementValue,
    "open_price": openPrice,
    "status": status,
    "ar": ar,
    "en": en,
    "fr": fr,
    "is_vip": isVip,
    "main_image": mainImage,
    "gallery": gallery,
  };
}

/// title : "m3rf4"
/// description : "bbb"

class FrBean {
  String title;
  String description;

  static FrBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FrBean frBean = FrBean();
    frBean.title = map['title'];
    frBean.description = map['description'];
    return frBean;
  }

  Map toJson() => {
    "title": title,
    "description": description,
  };
}

/// title : "hourse"
/// description : "bbb"

class EnBean {
  String title;
  String description;

  static EnBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    EnBean enBean = EnBean();
    enBean.title = map['title'];
    enBean.description = map['description'];
    return enBean;
  }

  Map toJson() => {
    "title": title,
    "description": description,
  };
}

/// title : "mechanical pencil"
/// description : "mechanical pencilmechanical pencilmechanical pencilmechanical pencil"

class ArBean {
  String title;
  String description;

  static ArBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ArBean arBean = ArBean();
    arBean.title = map['title'];
    arBean.description = map['description'];
    return arBean;
  }

  Map toJson() => {
    "title": title,
    "description": description,
  };
}