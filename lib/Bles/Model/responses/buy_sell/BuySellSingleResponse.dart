class BuySellSingleResponse {
  DataBean data;
  dynamic message;
  int code;

  static BuySellSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellSingleResponse buySellSingleResponseBean = BuySellSingleResponse();
    buySellSingleResponseBean.data = DataBean.fromMap(map['data']);
    buySellSingleResponseBean.message = map['message'];
    buySellSingleResponseBean.code = map['code'];
    return buySellSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  int id;
  String title;
  String description;
  dynamic categoryId;
  dynamic price;
  dynamic galleryId;
  dynamic sellerId;
  String phone;
  dynamic email;
  String status;
  dynamic promotion;
  dynamic address;
  dynamic country;
  dynamic governorate;
  dynamic city;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  SellerBean seller;
  String imageUrl;
  List<String> gallery;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
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
    dataBean.seller = SellerBean.fromMap(map['seller']);
    dataBean.imageUrl = map['image_url'];
    dataBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
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
    "seller": seller,
    "image_url": imageUrl,
    "gallery": gallery,
  };
}

class SellerBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  String phoneVerifiedAt;
  String type;
  String chanel;

  static SellerBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SellerBean sellerBean = SellerBean();
    sellerBean.id = map['id'];
    sellerBean.firstName = map['first_name'];
    sellerBean.lastName = map['last_name'];
    sellerBean.username = map['username'];
    sellerBean.phone = map['phone'];
    sellerBean.verificationCode = map['verification_code'];
    sellerBean.apiToken = map['api_token'];
    sellerBean.phoneVerifiedAt = map['phone_verified_at'];
    sellerBean.type = map['type'];
    sellerBean.chanel = map['chanel'];
    return sellerBean;
  }

  Map toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "phone": phone,
    "verification_code": verificationCode,
    "api_token": apiToken,
    "phone_verified_at": phoneVerifiedAt,
    "type": type,
    "chanel": chanel,
  };
}