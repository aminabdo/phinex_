import 'UserBean.dart';

class RatesBean {
  int id;
  dynamic rate;
  String comment;
  int userId;
  int objectId;
  dynamic categoryId;
  String objectName;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserData user;

  static RatesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RatesBean ratesBean = RatesBean();
    ratesBean.id = map['id'];
    ratesBean.rate = map['rate'];
    ratesBean.comment = map['comment'];
    ratesBean.userId = map['user_id'];
    ratesBean.objectId = map['object_id'];
    ratesBean.categoryId = map['category_id'];
    ratesBean.objectName = map['object_name'];
    ratesBean.createdAt = map['created_at'];
    ratesBean.updatedAt = map['updated_at'];
    ratesBean.deletedAt = map['deleted_at'];
    ratesBean.user = UserData.fromMap(map['user']);
    return ratesBean;
  }

  Map toJson() => {
    "id": id,
    "rate": rate,
    "comment": comment,
    "user_id": userId,
    "object_id": objectId,
    "category_id": categoryId,
    "object_name": objectName,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "user": user,
  };
}