class ProductResponse {
  DataBean data;
  String message;
  int code;

  static ProductResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProductResponse productResponseBean = ProductResponse();
    productResponseBean.data = DataBean.fromMap(map['data']);
    productResponseBean.message = map['message'];
    productResponseBean.code = map['code'];
    return productResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<ResturantMeals> meals;
  List<CategoriesBean> categories;
  FiltrationBean filtration;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.meals = List()..addAll(
      (map['products'] as List ?? []).map((o) => ResturantMeals.fromMap(o))
    );
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.filtration = FiltrationBean.fromMap(map['filtration']);
    return dataBean;
  }

  Map toJson() => {
    "products": meals,
    "categories": categories,
    "filtration": filtration,
  };
}

class FiltrationBean {
  int max_price;

  static FiltrationBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FiltrationBean filtrationBean = FiltrationBean();
    filtrationBean.max_price = map['max-price'];
    return filtrationBean;
  }

  Map toJson() => {
    "max-price": max_price,
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

class ResturantMeals {
  int id;
  String name;
  String description;
  String shortDescription;
  dynamic stockQuantity;
  dynamic regularPrice;
  dynamic salePrice;
  dynamic saleStartAt;
  dynamic saleEndAt;
  String stockStatus;
  dynamic totalReviews;
  dynamic totalRates;
  dynamic categoryId;
  String status;
  dynamic vendorId;
  dynamic hotOffer;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;
  dynamic imageId;
  dynamic storeId;
  String storeType;

  static ResturantMeals fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ResturantMeals productsBean = ResturantMeals();
    productsBean.id = map['id'];
    productsBean.name = map['name'];
    productsBean.description = map['description'];
    productsBean.shortDescription = map['short_description'];
    productsBean.stockQuantity = map['stock_quantity'];
    productsBean.regularPrice = num.parse(map['regular_price']);
    productsBean.salePrice = map['sale_price'];
    productsBean.saleStartAt = map['sale_start_at'];
    productsBean.saleEndAt = map['sale_end_at'];
    productsBean.stockStatus = map['stock_status'];
    productsBean.totalReviews = map['total_reviews'];
    productsBean.totalRates = num.parse(map['total_rates']);
    productsBean.categoryId = map['category_id'];
    productsBean.status = map['status'];
    productsBean.vendorId = map['vendor_id'];
    productsBean.hotOffer = map['hot_offer'];
    productsBean.deletedAt = map['deleted_at'];
    productsBean.createdAt = map['created_at'];
    productsBean.updatedAt = map['updated_at'];
    productsBean.imageUrl = map['image_url'];
    productsBean.imageId = map['image_id'];
    productsBean.storeId = map['store_id'];
    productsBean.storeType = map['store_type'];
    return productsBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "short_description": shortDescription,
    "stock_quantity": stockQuantity,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "sale_start_at": saleStartAt,
    "sale_end_at": saleEndAt,
    "stock_status": stockStatus,
    "total_reviews": totalReviews,
    "total_rates": totalRates,
    "category_id": categoryId,
    "status": status,
    "vendor_id": vendorId,
    "hot_offer": hotOffer,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}