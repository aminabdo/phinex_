import 'package:phinex/utils/base/BaseResponse.dart';

class DeleteFromWishList extends BaseResponse {
  DataBean data;

  static DeleteFromWishList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DeleteFromWishList deleteFromWishListBean = DeleteFromWishList();
    deleteFromWishListBean.data = DataBean.fromMap(map['data']);
    //deleteFromWishListBean.message = map['message'];
    deleteFromWishListBean.code = map['code'];
    return deleteFromWishListBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  int id;
  int productId;
  int userId;
  String createdAt;
  String updatedAt;
  Deleted_atBean deletedAt;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.productId = map['product_id'];
    dataBean.userId = map['user_id'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = Deleted_atBean.fromMap(map['deleted_at']);
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class Deleted_atBean {
  String date;
  int timezoneType;
  String timezone;

  static Deleted_atBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Deleted_atBean deleted_atBean = Deleted_atBean();
    deleted_atBean.date = map['date'];
    deleted_atBean.timezoneType = map['timezone_type'];
    deleted_atBean.timezone = map['timezone'];
    return deleted_atBean;
  }

  Map toJson() => {
    "date": date,
    "timezone_type": timezoneType,
    "timezone": timezone,
  };
}