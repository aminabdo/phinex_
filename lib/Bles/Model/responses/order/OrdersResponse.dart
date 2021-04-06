class OrdersResponse {
  List<Order> data;
  dynamic message;
  int code;

  static OrdersResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OrdersResponse ordersResponseBean = OrdersResponse();
    ordersResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Order.fromMap(o))
    );
    ordersResponseBean.message = map['message'];
    ordersResponseBean.code = map['code'];
    return ordersResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class Order {
  dynamic id;
  dynamic userId;
  String status;
  String payment;
  dynamic anotherShippingAddress;
  dynamic total;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static Order fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Order dataBean = Order();
    dataBean.id = map['id'];
    dataBean.userId = map['user_id'];
    dataBean.status = map['status'];
    dataBean.payment = map['payment'];
    dataBean.anotherShippingAddress = map['another_shipping_address'];
    dataBean.total = map['total'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
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
  };
}