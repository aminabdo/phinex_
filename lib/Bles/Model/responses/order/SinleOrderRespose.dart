class SinleOrderRespose {
  DataBean data;
  dynamic message;
  dynamic code;

  static SinleOrderRespose fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SinleOrderRespose sinleOrderResposeBean = SinleOrderRespose();
    sinleOrderResposeBean.data = DataBean.fromMap(map['data']);
    sinleOrderResposeBean.message = map['message'];
    sinleOrderResposeBean.code = map['code'];
    return sinleOrderResposeBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  dynamic id;
  dynamic userId;
  String status;
  String payment;
  dynamic anotherShippingAddress;
  dynamic total;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  List<OrderItemsBean> orderItems;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.userId = map['user_id'];
    dataBean.status = map['status'];
    dataBean.payment = map['payment'];
    dataBean.anotherShippingAddress = map['another_shipping_address'];
    dataBean.total = map['total'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.orderItems = List()..addAll(
      (map['orderItems'] as List ?? []).map((o) => OrderItemsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "status": status,
    "payment": payment,
    "another_shipping_address": anotherShippingAddress,
    "total": total,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "orderItems": orderItems,
  };
}

class OrderItemsBean {
  dynamic id;
  dynamic orderId;
  dynamic productId;
  dynamic vendorId;
  dynamic userId;
  dynamic quantity;
  dynamic price;
  String status;
  dynamic coupon;
  dynamic attribute;
  dynamic value;
  String deletedAt;
  dynamic createdAt;
  String updatedAt;
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
  dynamic imageId;
  dynamic storeId;
  dynamic storeType;
  dynamic hotOffer;
  String image;
  String productName;
  String vendorName;

  static OrderItemsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OrderItemsBean orderItemsBean = OrderItemsBean();
    orderItemsBean.id = map['id'];
    orderItemsBean.orderId = map['order_id'];
    orderItemsBean.productId = map['product_id'];
    orderItemsBean.vendorId = map['vendor_id'];
    orderItemsBean.userId = map['user_id'];
    orderItemsBean.quantity = map['quantity'];
    orderItemsBean.price = map['price'];
    orderItemsBean.status = map['status'];
    orderItemsBean.coupon = map['coupon'];
    orderItemsBean.attribute = map['attribute'];
    orderItemsBean.value = map['value'];
    orderItemsBean.deletedAt = map['deleted_at'];
    orderItemsBean.createdAt = map['created_at'];
    orderItemsBean.updatedAt = map['updated_at'];
    orderItemsBean.name = map['name'];
    orderItemsBean.description = map['description'];
    orderItemsBean.shortDescription = map['short_description'];
    orderItemsBean.stockQuantity = map['stock_quantity'];
    orderItemsBean.regularPrice = map['regular_price'];
    orderItemsBean.salePrice = map['sale_price'];
    orderItemsBean.saleStartAt = map['sale_start_at'];
    orderItemsBean.saleEndAt = map['sale_end_at'];
    orderItemsBean.stockStatus = map['stock_status'];
    orderItemsBean.totalReviews = map['total_reviews'];
    orderItemsBean.totalRates = map['total_rates'];
    orderItemsBean.categoryId = map['category_id'];
    orderItemsBean.imageId = map['image_id'];
    orderItemsBean.storeId = map['store_id'];
    orderItemsBean.storeType = map['store_type'];
    orderItemsBean.hotOffer = map['hot_offer'];
    orderItemsBean.image = map['image'];
    orderItemsBean.productName = map['product_name'];
    orderItemsBean.vendorName = map['vendor_name'];
    return orderItemsBean;
  }

  Map toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "vendor_id": vendorId,
    "user_id": userId,
    "quantity": quantity,
    "price": price,
    "status": status,
    "coupon": coupon,
    "attribute": attribute,
    "value": value,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
    "store_id": storeId,
    "store_type": storeType,
    "hot_offer": hotOffer,
    "image": image,
    "product_name": productName,
    "vendor_name": vendorName,
  };
}