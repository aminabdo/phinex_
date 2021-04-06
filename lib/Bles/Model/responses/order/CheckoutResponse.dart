/// data : {"status":"processing","user_id":"8","payment":"payment","another_shipping_address":"another address","total":"600","updated_at":"2020-11-24T10:49:29.000000Z","created_at":"2020-11-24T10:49:29.000000Z","id":34}
/// message : null
/// code : 201

class CheckoutResponse {
  OrderBean data;
  dynamic message;
  int code;

  static CheckoutResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CheckoutResponse checkoutResponseBean = CheckoutResponse();
    checkoutResponseBean.data = OrderBean.fromMap(map['data']);
    checkoutResponseBean.message = map['message'];
    checkoutResponseBean.code = map['code'];
    return checkoutResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class OrderBean {
  String status;
  String userId;
  String payment;
  String anotherShippingAddress;
  String total;
  String updatedAt;
  String createdAt;
  int id;

  static OrderBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OrderBean dataBean = OrderBean();
    dataBean.status = map['status'];
    dataBean.userId = map['user_id'];
    dataBean.payment = map['payment'];
    dataBean.anotherShippingAddress = map['another_shipping_address'];
    dataBean.total = map['total'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.id = map['id'];
    return dataBean;
  }

  Map toJson() => {
    "status": status,
    "user_id": userId,
    "payment": payment,
    "another_shipping_address": anotherShippingAddress,
    "total": total,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}