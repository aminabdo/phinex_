/// product : [{"id":76,"name":"Congistalss","description":"congistal","short_description":"congistal","stock_quantity":2,"regular_price":500,"sale_price":112,"sale_start_at":"2020-11-25 00:00:00","sale_end_at":"2020-11-28 00:00:00","stock_status":"1","total_reviews":0,"total_rates":0,"category_id":809,"image_id":3254,"status":"published","vendor_id":379,"store_id":null,"store_type":null,"hot_offer":0,"deleted_at":null,"created_at":"2020-11-30T11:27:22.000000Z","updated_at":"2020-12-01T10:25:43.000000Z","image_url":"https://images.tbdm.net/storage/app/public/images/2020-11/30-Mon/congistal.jpeg"}]
/// message : null
/// code : 200

class PharmacyProductsResponse {
  List<ProductsBean> product;
  dynamic message;
  int code;

  static PharmacyProductsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PharmacyProductsResponse pharmacyProductsResponseBean = PharmacyProductsResponse();
    pharmacyProductsResponseBean.product = List()..addAll(
      (map['product'] as List ?? []).map((o) => ProductsBean.fromMap(o))
    );
    pharmacyProductsResponseBean.message = map['message'];
    pharmacyProductsResponseBean.code = map['code'];
    return pharmacyProductsResponseBean;
  }

  Map toJson() => {
    "product": product,
    "message": message,
    "code": code,
  };

}

class ProductsBean {
  int id;
  String name;
  String description;
  String shortDescription;
  int stockQuantity;
  int regularPrice;
  int salePrice;
  String saleStartAt;
  String saleEndAt;
  String stockStatus;
  int totalReviews;
  int totalRates;
  int categoryId;
  int imageId;
  String status;
  int vendorId;
  dynamic storeId;
  dynamic storeType;
  int hotOffer;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;

  static ProductsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProductsBean productBean = ProductsBean();
    productBean.id = map['id'];
    productBean.name = map['name'];
    productBean.description = map['description'];
    productBean.shortDescription = map['short_description'];
    productBean.stockQuantity = map['stock_quantity'];
    productBean.regularPrice = map['regular_price'];
    productBean.salePrice = map['sale_price'];
    productBean.saleStartAt = map['sale_start_at'];
    productBean.saleEndAt = map['sale_end_at'];
    productBean.stockStatus = map['stock_status'];
    productBean.totalReviews = map['total_reviews'];
    productBean.totalRates = map['total_rates'];
    productBean.categoryId = map['category_id'];
    productBean.imageId = map['image_id'];
    productBean.status = map['status'];
    productBean.vendorId = map['vendor_id'];
    productBean.storeId = map['store_id'];
    productBean.storeType = map['store_type'];
    productBean.hotOffer = map['hot_offer'];
    productBean.deletedAt = map['deleted_at'];
    productBean.createdAt = map['created_at'];
    productBean.updatedAt = map['updated_at'];
    productBean.imageUrl = map['image_url'];
    return productBean;
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
    "store_id": storeId,
    "store_type": storeType,
    "hot_offer": hotOffer,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}