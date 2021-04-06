class RelatedByCategoryBean {
  int id;
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

  static RelatedByCategoryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RelatedByCategoryBean relatedByCategoryBean = RelatedByCategoryBean();
    relatedByCategoryBean.id = map['id'];
    relatedByCategoryBean.name = map['name'];
    relatedByCategoryBean.description = map['description'];
    relatedByCategoryBean.shortDescription = map['short_description'];
    relatedByCategoryBean.stockQuantity = map['stock_quantity'];
    relatedByCategoryBean.regularPrice = num.parse(map['regular_price'].toString());
    relatedByCategoryBean.salePrice = map['sale_price'];
    relatedByCategoryBean.saleStartAt = map['sale_start_at'];
    relatedByCategoryBean.saleEndAt = map['sale_end_at'];
    relatedByCategoryBean.stockStatus = map['stock_status'];
    relatedByCategoryBean.totalReviews = map['total_reviews'];
    relatedByCategoryBean.totalRates = map['total_rates'];
    relatedByCategoryBean.categoryId = map['category_id'];
    relatedByCategoryBean.imageId = map['image_id'];
    relatedByCategoryBean.status = map['status'];
    relatedByCategoryBean.vendorId = map['vendor_id'];
    relatedByCategoryBean.hotOffer = map['hot_offer'];
    relatedByCategoryBean.deletedAt = map['deleted_at'];
    relatedByCategoryBean.createdAt = map['created_at'];
    relatedByCategoryBean.updatedAt = map['updated_at'];
    relatedByCategoryBean.imageUrl = map['image_url'];
    return relatedByCategoryBean;
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