class BuySellLandingResponse {
  DataBean data;
  String message;
  int code;

  static BuySellLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BuySellLandingResponse buySellLandingResponseBean = BuySellLandingResponse();
    buySellLandingResponseBean.data = DataBean.fromMap(map['data']);
    buySellLandingResponseBean.message = map['message'];
    buySellLandingResponseBean.code = map['code'];
    return buySellLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<CategoriesBean> categories;
  List<CategoriesItemsBean> categoriesItems;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.categoriesItems = List()..addAll(
      (map['categoriesItems'] as List ?? []).map((o) => CategoriesItemsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "categories": categories,
    "categoriesItems": categoriesItems,
  };

  @override
  String toString() {
    return 'DataBean{categories: $categories, categoriesItems: $categoriesItems}';
  }
}

class CategoriesItemsBean {
  int id;
  String name;

  @override
  String toString() {
    return 'CategoriesItemsBean{id: $id, name: $name, description: $description, keywords: $keywords, icon: $icon, parentId: $parentId, imageId: $imageId, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, items: $items}';
  }

  String description;
  String keywords;
  String icon;
  dynamic parentId;
  dynamic imageId;
  String deletedAt;
  String createdAt;
  String updatedAt;
  List<ItemsBean> items;

  static CategoriesItemsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesItemsBean categoriesItemsBean = CategoriesItemsBean();
    categoriesItemsBean.id = map['id'];
    categoriesItemsBean.name = map['name'];
    categoriesItemsBean.description = map['description'];
    categoriesItemsBean.keywords = map['keywords'];
    categoriesItemsBean.icon = map['icon'];
    categoriesItemsBean.parentId = map['parent_id'];
    categoriesItemsBean.imageId = map['image_id'];
    categoriesItemsBean.deletedAt = map['deleted_at'];
    categoriesItemsBean.createdAt = map['created_at'];
    categoriesItemsBean.updatedAt = map['updated_at'];
    categoriesItemsBean.items = List()..addAll(
      (map['items'] as List ?? []).map((o) => ItemsBean.fromMap(o))
    );
    return categoriesItemsBean;
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
    "items": items,
  };
}

class ItemsBean {
  int id;
  String title;

  @override
  String toString() {
    return 'ItemsBean{id: $id, title: $title, description: $description, categoryId: $categoryId, price: $price, galleryId: $galleryId, sellerId: $sellerId, phone: $phone, email: $email, status: $status, promotion: $promotion, address: $address, country: $country, governorate: $governorate, city: $city, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt, imageUrl: $imageUrl}';
  }

  String description;
  dynamic categoryId;
  dynamic price;
  dynamic galleryId;
  dynamic sellerId;
  String phone;
  String email;
  String status;
  String promotion;
  String address;
  dynamic country;
  dynamic governorate;
  dynamic city;
  String deletedAt;
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
    itemsBean.price = map['price'];
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
  String icon;
  dynamic parentId;
  dynamic imageId;
  String deletedAt;
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

  @override
  String toString() {
    return 'CategoriesBean{id: $id, name: $name, description: $description, keywords: $keywords, icon: $icon, parentId: $parentId, imageId: $imageId, deletedAt: $deletedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
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