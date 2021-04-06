class GeneralModelGovResponse {
  DataBean data;
  dynamic message;
  int code;

  static GeneralModelGovResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GeneralModelGovResponse generalModelGovResponseBean = GeneralModelGovResponse();
    generalModelGovResponseBean.data = DataBean.fromMap(map['data']);
    generalModelGovResponseBean.message = map['message'];
    generalModelGovResponseBean.code = map['code'];
    return generalModelGovResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<Governorates> governorates;
  List<Models> models;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.governorates = List()..addAll(
      (map['governorates'] as List ?? []).map((o) => Governorates.fromMap(o))
    );
    dataBean.models = List()..addAll(
      (map['models'] as List ?? []).map((o) => Models.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "governorates": governorates,
    "models": models,
  };
}

class Models {
  int id;
  String modelName;
  String parentId;
  int imageId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<dynamic> children;

  static Models fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Models modelsBean = Models();
    modelsBean.id = map['id'];
    modelsBean.modelName = map['model_name'];
    modelsBean.parentId = map['parent_id'];
    modelsBean.imageId = map['image_id'];
    modelsBean.createdAt = map['created_at'];
    modelsBean.updatedAt = map['updated_at'];
    modelsBean.deletedAt = map['deleted_at'];
    modelsBean.children = map['children'];
    return modelsBean;
  }

  Map toJson() => {
    "id": id,
    "model_name": modelName,
    "parent_id": parentId,
    "image_id": imageId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "children": children,
  };
}

class Governorates {
  int id;
  String name;
  int countryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  List<Cities> cities;

  static Governorates fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Governorates governoratesBean = Governorates();
    governoratesBean.id = map['id'];
    governoratesBean.name = map['name'];
    governoratesBean.countryId = map['country_id'];
    governoratesBean.createdAt = map['created_at'];
    governoratesBean.updatedAt = map['updated_at'];
    governoratesBean.deletedAt = map['deleted_at'];
    governoratesBean.cities = List()..addAll(
      (map['cities'] as List ?? []).map((o) => Cities.fromMap(o))
    );
    return governoratesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "cities": cities,
  };
}

class Cities {
  int id;
  String name;
  int governorateId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  static Cities fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Cities citiesBean = Cities();
    citiesBean.id = map['id'];
    citiesBean.name = map['name'];
    citiesBean.governorateId = map['governorate_id'];
    citiesBean.createdAt = map['created_at'];
    citiesBean.updatedAt = map['updated_at'];
    citiesBean.deletedAt = map['deleted_at'];
    return citiesBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "governorate_id": governorateId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}