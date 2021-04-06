class RelatedByVendorBean {
  int id;
  String name;
  String description;
  String shortDescription;
  dynamic stockQuantity;
  dynamic regularPrice;
  dynamic salePrice;
  String saleStartAt;
  String saleEndAt;
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

  static RelatedByVendorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RelatedByVendorBean relatedByVendorBean = RelatedByVendorBean();
    relatedByVendorBean.id = map['id'];
    relatedByVendorBean.name = map['name'];
    relatedByVendorBean.description = map['description'];
    relatedByVendorBean.shortDescription = map['short_description'];
    relatedByVendorBean.stockQuantity = map['stock_quantity'];
    relatedByVendorBean.regularPrice = map['regular_price'];
    relatedByVendorBean.salePrice = map['sale_price'];
    relatedByVendorBean.saleStartAt = map['sale_start_at'];
    relatedByVendorBean.saleEndAt = map['sale_end_at'];
    relatedByVendorBean.stockStatus = map['stock_status'];
    relatedByVendorBean.totalReviews = map['total_reviews'];
    relatedByVendorBean.totalRates = map['total_rates'];
    relatedByVendorBean.categoryId = map['category_id'];
    relatedByVendorBean.imageId = map['image_id'];
    relatedByVendorBean.status = map['status'];
    relatedByVendorBean.vendorId = map['vendor_id'];
    relatedByVendorBean.hotOffer = map['hot_offer'];
    relatedByVendorBean.deletedAt = map['deleted_at'];
    relatedByVendorBean.createdAt = map['created_at'];
    relatedByVendorBean.updatedAt = map['updated_at'];
    relatedByVendorBean.imageUrl = map['image_url'];
    return relatedByVendorBean;
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