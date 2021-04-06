
import 'package:phinex/Bles/Model/responses/store/store_responses/ProductsBean.dart';

class FilterResponse {
  DataBean data;
  dynamic message;
  int code;

  static FilterResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FilterResponse filterResponseBean = FilterResponse();
    filterResponseBean.data = DataBean.fromMap(map['data']);
    filterResponseBean.message = map['message'];
    filterResponseBean.code = map['code'];
    return filterResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<Products_categoriesBean> productsCategories;
  List<CategoriesBean> categories;
  FiltrationBean filtration;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.productsCategories = List()..addAll(
      (map['products_categories'] as List ?? []).map((o) => Products_categoriesBean.fromMap(o))
    );
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    dataBean.filtration = FiltrationBean.fromMap(map['filtration']);
    return dataBean;
  }

  Map toJson() => {
    "products_categories": productsCategories,
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
  dynamic parentId;
  dynamic imageId;
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

class Products_categoriesBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<ProductsBean> products;

  static Products_categoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Products_categoriesBean products_categoriesBean = Products_categoriesBean();
    products_categoriesBean.id = map['id'];
    products_categoriesBean.name = map['name'];
    products_categoriesBean.description = map['description'];
    products_categoriesBean.keywords = map['keywords'];
    products_categoriesBean.icon = map['icon'];
    products_categoriesBean.parentId = map['parent_id'];
    products_categoriesBean.imageId = map['image_id'];
    products_categoriesBean.deletedAt = map['deleted_at'];
    products_categoriesBean.createdAt = map['created_at'];
    products_categoriesBean.updatedAt = map['updated_at'];
    products_categoriesBean.products = List()..addAll(
      (map['products'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    return products_categoriesBean;
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
    "products": products,
  };
}

