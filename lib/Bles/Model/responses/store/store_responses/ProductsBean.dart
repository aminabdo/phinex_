class ProductsBean {
  dynamic id;
  String name;
  String description;
  String shortDescription;
  dynamic stockQuantity;
  num regularPrice;
  dynamic salePrice;
  dynamic saleStartAt;
  dynamic saleEndAt;
  String stockStatus;
  dynamic totalReviews;
  dynamic totalRates;
  dynamic categoryId;
  dynamic imageId;
  String status;
  dynamic vendorId;
  dynamic hotOffer;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;
  String category;
  bool wishlis;
  int cartQty;
  List<String> gallery;

  ProductsBean({this.id, this.imageUrl, this.name, this.totalRates, this.regularPrice, this.vendorId});

  static ProductsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProductsBean productsBeanBean = ProductsBean();
    productsBeanBean.id = map['id'];
    productsBeanBean.name = map['name'];
    productsBeanBean.description = map['description'];
    productsBeanBean.shortDescription = map['short_description'];
    productsBeanBean.stockQuantity = map['stock_quantity'];
    productsBeanBean.regularPrice = num.parse(map['regular_price'].toString());
    productsBeanBean.salePrice = map['sale_price'];
    productsBeanBean.saleStartAt = map['sale_start_at'];
    productsBeanBean.saleEndAt = map['sale_end_at'];
    productsBeanBean.stockStatus = map['stock_status'];
    productsBeanBean.totalReviews = map['total_reviews'];
    productsBeanBean.totalRates = map['total_rates'];
    productsBeanBean.categoryId = map['category_id'];
    productsBeanBean.imageId = map['image_id'];
    productsBeanBean.status = map['status'];
    productsBeanBean.vendorId = map['vendor_id'];
    productsBeanBean.hotOffer = map['hot_offer'];
    productsBeanBean.deletedAt = map['deleted_at'];
    productsBeanBean.createdAt = map['created_at'];
    productsBeanBean.updatedAt = map['updated_at'];
    productsBeanBean.imageUrl = map['image_url'];
    productsBeanBean.category = map['category'];
    productsBeanBean.gallery = List()..addAll(
      (map['gallery'] as List ?? []).map((o) => o.toString())
    );
    return productsBeanBean;
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
    "image_id": imageId,
    "status": status,
    "vendor_id": vendorId,
    "hot_offer": hotOffer,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
    "category": category,
    "gallery": gallery,
  };
}