class ProductsBean {
  int id;
  String name;
  String description;
  String shortDescription;
  dynamic stockQuantity;
  int regularPrice;
  dynamic salePrice;
  String saleStartAt;
  String saleEndAt;
  String stockStatus;
  dynamic totalReviews;
  int totalRates;
  int categoryId;
  int imageId;
  String status;
  int vendorId;
  int hotOffer;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;

  static ProductsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProductsBean productsBean = ProductsBean();
    productsBean.id = map['id'];
    productsBean.name = map['name'];
    productsBean.description = map['description'];
    productsBean.shortDescription = map['short_description'];
    productsBean.stockQuantity = map['stock_quantity'];
    productsBean.regularPrice = map['regular_price'];
    productsBean.salePrice = map['sale_price'];
    productsBean.saleStartAt = map['sale_start_at'];
    productsBean.saleEndAt = map['sale_end_at'];
    productsBean.stockStatus = map['stock_status'];
    productsBean.totalReviews = map['total_reviews'];
    productsBean.totalRates = map['total_rates'];
    productsBean.categoryId = map['category_id'];
    productsBean.imageId = map['image_id'];
    productsBean.status = map['status'];
    productsBean.vendorId = map['vendor_id'];
    productsBean.hotOffer = map['hot_offer'];
    productsBean.deletedAt = map['deleted_at'];
    productsBean.createdAt = map['created_at'];
    productsBean.updatedAt = map['updated_at'];
    productsBean.imageUrl = map['image_url'];
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
    "image_id": imageId,
    "status": status,
    "vendor_id": vendorId,
    "hot_offer": hotOffer,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}
