/// data : [{"id":20025,"name":"Clubs","description":"Clubs","keywords":"Clubs","icon":null,"parent_id":20014,"image_id":4285,"deleted_at":null,"created_at":"2021-01-09T17:33:57.000000Z","updated_at":"2021-01-09T17:33:57.000000Z","lang":"en","image_url":"https://images.tbdm.net/storage/app/public/images/2021-01/09-Sat/5ff9e9054e70a.jpeg"},{"id":20026,"name":"Gyms","description":"Gyms","keywords":"Gyms","icon":null,"parent_id":20014,"image_id":4286,"deleted_at":null,"created_at":"2021-01-09T17:37:21.000000Z","updated_at":"2021-01-09T17:37:21.000000Z","lang":"en","image_url":"https://images.tbdm.net/storage/app/public/images/2021-01/09-Sat/5ff9e9d12bc4e.jpeg"}]
/// message : null
/// code : 200

class CatalogueLandingResponse {
  List<CatalogueCat> data;
  dynamic message;
  int code;

  static CatalogueLandingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CatalogueLandingResponse catalogueLandingResponseBean = CatalogueLandingResponse();
    catalogueLandingResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => CatalogueCat.fromMap(o))
    );
    catalogueLandingResponseBean.message = map['message'];
    catalogueLandingResponseBean.code = map['code'];
    return catalogueLandingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class CatalogueCat {
  int id;
  String name;
  String description;
  String keywords;
  dynamic icon;
  int parentId;
  int imageId;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String lang;
  String imageUrl;

  static CatalogueCat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CatalogueCat dataBean = CatalogueCat();
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
    dataBean.lang = map['lang'];
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
    "lang": lang,
    "image_url": imageUrl,
  };
}