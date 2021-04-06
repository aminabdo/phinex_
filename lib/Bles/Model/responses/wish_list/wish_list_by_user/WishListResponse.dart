import 'package:phinex/utils/base/BaseResponse.dart';

class WishListResponse extends BaseResponse {

  List<WishListBean> data;

  static WishListResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WishListResponse wishListResponseBean = WishListResponse();
    wishListResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => WishListBean.fromMap(o))
    );
    wishListResponseBean.message = map['message'];
    wishListResponseBean.code = map['code'];
    return wishListResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class WishListBean {
  dynamic id;
  dynamic productId;
  dynamic userId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  ProductBean product;

  static WishListBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    WishListBean dataBean = WishListBean();
    dataBean.id = map['id'];
    dataBean.productId = map['product_id'];
    dataBean.userId = map['user_id'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.product = ProductBean.fromMap(map['product']);
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "product": product,
  };
}

class ProductBean {
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

  static ProductBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProductBean productBean = ProductBean();
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
    "hot_offer": hotOffer,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}