import 'UserBean.dart';

class RatingBean {
  int id;
  double rate;
  String comment;
  int userId;
  int objectId;
  dynamic categoryId;
  String objectName;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  UserBean user;

  static RatingBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RatingBean ratingBean = RatingBean();
    ratingBean.id = map['id'];
    //ratingBean.rate = map['rate'];
    ratingBean.comment = map['comment'];
    ratingBean.userId = map['user_id'];
    ratingBean.objectId = map['object_id'];
    ratingBean.categoryId = map['category_id'];
    ratingBean.objectName = map['object_name'];
    ratingBean.createdAt = map['created_at'];
    ratingBean.updatedAt = map['updated_at'];
    ratingBean.deletedAt = map['deleted_at'];
    ratingBean.user = UserBean.fromMap(map['user']);
    return ratingBean;
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
