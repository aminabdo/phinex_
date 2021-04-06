class BuySellByCatReposnse {
  DataBean data;
  dynamic message;
  int code;

  static BuySellByCatReposnse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellByCatReposnse buySellByCatReposnseBean = BuySellByCatReposnse();
    buySellByCatReposnseBean.data = DataBean.fromMap(map['data']);
    buySellByCatReposnseBean.message = map['message'];
    buySellByCatReposnseBean.code = map['code'];
    return buySellByCatReposnseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<CategoriesBean> categories;
  List<ItemsBean> items;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.items = List()..addAll(
      (map['items'] as List ?? []).map((o) => ItemsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "categories": categories,
    "items": items,
  };
}

class ItemsBean {
  int id;
  String title;
  String description;
  int categoryId;
  num price;
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

  static ItemsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ItemsBean itemsBean = ItemsBean();
    itemsBean.id = map['id'];
    itemsBean.title = map['title'];
    itemsBean.description = map['description'];
    itemsBean.categoryId = map['category_id'];
    itemsBean.price = num.parse(map['price'].toString());
    itemsBean.galleryId = map['gallery_id'];
    itemsBean.sellerId = map['seller_id'];
    itemsBean.phone = map['phone'];
    itemsBean.email = map['email'];
    itemsBean.status = map['status'];
    itemsBean.promotion = map['promotion'];
    itemsBean.address = map['address'];
    itemsBean.country = map['country'];
    itemsBean.governorate = map['governorate'];
    itemsBean.city = map['city'];
    itemsBean.deletedAt = map['deleted_at'];
    itemsBean.createdAt = map['created_at'];
    itemsBean.updatedAt = map['updated_at'];
    itemsBean.imageUrl = map['image_url'];
    return itemsBean;
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

class CategoriesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  int parentId;
  int imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static CategoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesBean categoriesBean = CategoriesBean();
    categoriesBean.id = map['id'];
    categoriesBean.name = map['name'];
    categoriesBean.description = map['description'];
    categoriesBean.keywords = map['keywords'];
    categoriesBean.icon = map['icon'];
    categoriesBean.parentId = map['parent_id'];
    categoriesBean.imageId = map['image_id'];
    categoriesBean.deletedAt = map['deleted_at'];
    categoriesBean.createdAt = map['created_at'];
    categoriesBean.updatedAt = map['updated_at'];
    return categoriesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}