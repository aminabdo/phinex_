class IndexLandingResponse {
  List<DataBean> data;
  dynamic message;
  int code;

  static IndexLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IndexLandingResponse indexLandingResponseBean = IndexLandingResponse();
    indexLandingResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => DataBean.fromMap(o))
    );
    indexLandingResponseBean.message = map['message'];
    indexLandingResponseBean.code = map['code'];
    return indexLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  dynamic parentId;
  dynamic imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String imageUrl;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.id = map['id'];
    dataBean.name = map['name'];
    dataBean.description = map['description'];
    dataBean.keywords = map['keywords'];
    dataBean.icon = map['icon'];
    dataBean.parentId = map['parent_id'];
    dataBean.imageId = map['image_id'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.imageUrl = map['image_url'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "keywords": keywords,
    "icon": icon,
    "parent_id": parentId,
    "image_id": imageId,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "image_url": imageUrl,
  };
}