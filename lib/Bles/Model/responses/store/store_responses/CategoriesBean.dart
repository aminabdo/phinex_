import 'ProductsBean.dart';

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
  List<ProductsBean> products;

  static CategoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesBean dataBean = CategoriesBean();
    dataBean.id = map['id'];
    dataBean.name = map['name'];
    dataBean.description = map['description'];
    dataBean.keywords = map['keywords'];
    dataBean.icon = map['icon'];
    dataBean.parentId = map['parent_id'];
    dataBean.imageId = map['image_id'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.products = List()..addAll(
        (map['products'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    return dataBean;
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
