class BuySellSearchResponse {
  BuySellSearchData data;
  dynamic message;
  int code;

  static BuySellSearchResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellSearchResponse indexSearchResponseBean = BuySellSearchResponse();
    indexSearchResponseBean.data = BuySellSearchData.fromMap(map['data']);
    indexSearchResponseBean.message = map['message'];
    indexSearchResponseBean.code = map['code'];
    return indexSearchResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class BuySellSearchData {
  List<BuySellDataResult> results;
  int total;

  BuySellSearchData({this.results, this.total});

  static BuySellSearchData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellSearchData searchResult = BuySellSearchData();
    searchResult.results = List()..addAll((map['results'] as List ?? []).map((o) => BuySellDataResult.fromMap(o)));
    searchResult.total = map['total'];
    return searchResult;
  }
}


class BuySellDataResult {
  int id;
  String title;
  String description;
  int categoryId;
  dynamic price;
  int galleryId;
  int sellerId;
  String phone;
  dynamic email;
  String status;
  dynamic promotion;
  dynamic address;
  int country;
  int governorate;
  int city;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;

  static BuySellDataResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellDataResult dataBean = BuySellDataResult();
    dataBean.id = map['id'];
    dataBean.title = map['title'];
    dataBean.description = map['description'];
    dataBean.categoryId = map['category_id'];
    dataBean.price = map['price'];
    dataBean.galleryId = map['gallery_id'];
    dataBean.sellerId = map['seller_id'];
    dataBean.phone = map['phone'];
    dataBean.email = map['email'];
    dataBean.status = map['status'];
    dataBean.promotion = map['promotion'];
    dataBean.address = map['address'];
    dataBean.country = map['country'];
    dataBean.governorate = map['governorate'];
    dataBean.city = map['city'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.imageUrl = map['image_url'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category_id": categoryId,
    "price": price,
    "gallery_id": galleryId,
    "seller_id": sellerId,
    "phone": phone,
    "email": email,
    "status": status,
    "promotion": promotion,
    "address": address,
    "country": country,
    "governorate": governorate,
    "city": city,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}