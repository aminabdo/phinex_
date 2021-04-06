
class CartUserResponse {

  List<CartUserBean> data;
  double totalPrice;
  dynamic message;
  int code;

  static CartUserResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CartUserResponse cartUserResponseBean = CartUserResponse();
    cartUserResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => CartUserBean.fromMap(o))
    );

    cartUserResponseBean = calcualteTotalPrice(cartUserResponseBean);
    cartUserResponseBean.message = map['message'];
    cartUserResponseBean.code = map['code'];
    return cartUserResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };

  static calcualteTotalPrice(CartUserResponse cartUserResponse){
    cartUserResponse.totalPrice = 0 ;
    cartUserResponse.data.forEach((element) {
      cartUserResponse.totalPrice += (num.parse(element.quantity.toString()) * num.parse(element.regularPrice.toString()));
    });
    return cartUserResponse ;
  }


}


class CartUserBean {
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
  dynamic productId;
  String imageUrl;
  dynamic userId;
  dynamic quantity;

  static CartUserBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CartUserBean dataBean = CartUserBean();
    dataBean.id = map['id'];
    dataBean.name = map['name'];
    dataBean.description = map['description'];
    dataBean.shortDescription = map['short_description'];
    dataBean.stockQuantity = map['stock_quantity'];
    dataBean.regularPrice = num.parse(map['regular_price'].toString());
    dataBean.salePrice = map['sale_price'];
    dataBean.saleStartAt = map['sale_start_at'];
    dataBean.saleEndAt = map['sale_end_at'];
    dataBean.stockStatus = map['stock_status'];
    dataBean.totalReviews = map['total_reviews'];
    dataBean.totalRates = map['total_rates'];
    dataBean.categoryId = map['category_id'];
    dataBean.imageId = map['image_id'];
    dataBean.status = map['status'];
    dataBean.vendorId = map['vendor_id'];
    dataBean.hotOffer = map['hot_offer'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.productId = map['product_id'];
    dataBean.imageUrl = map['image_url'];
    dataBean.userId = map['user_id'];
    dataBean.quantity = map['quantity'];
    return dataBean;
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
    "product_id": productId,
    "image_url": imageUrl,
    "user_id": userId,
    "quantity": quantity,
  };
}