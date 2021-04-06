import 'package:phinex/utils/base/BaseResponse.dart';

class AddToWishListResponse extends BaseResponse {
  DataBean data;

  static AddToWishListResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AddToWishListResponse addToWishListBean = AddToWishListResponse();
    addToWishListBean.data = DataBean.fromMap(map['data']);
    addToWishListBean.message = map['message'];
    addToWishListBean.code = map['code'];
    return addToWishListBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  String productId;
  String userId;
  String updatedAt;
  String createdAt;
  int id;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.productId = map['product_id'];
    dataBean.userId = map['user_id'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.id = map['id'];
    return dataBean;
  }

  Map toJson() => {
    "product_id": productId,
    "user_id": userId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}