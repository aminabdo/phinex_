class DriverCreateDetailsResponse {
  DataBean data;
  dynamic message;
  int code;

  static DriverCreateDetailsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DriverCreateDetailsResponse driverCreateDetailsResponseBean = DriverCreateDetailsResponse();
    driverCreateDetailsResponseBean.data = DataBean.fromMap(map['data']);
    driverCreateDetailsResponseBean.message = map['message'];
    driverCreateDetailsResponseBean.code = map['code'];
    return driverCreateDetailsResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  CountryBean country;
  List<CarModel> models;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.country = CountryBean.fromMap(map['country']);
    dataBean.models = List()..addAll(
      (map['models'] as List ?? []).map((o) => CarModel.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "country": country,
    "models": models,
  };
}

class CarModel {
  int id;
  String modelName;
  String parentId;
  int imageId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<dynamic> children;

  static CarModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CarModel modelsBean = CarModel();
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

class CountryBean {
  List<GovernoratesBean> governorates;

  static CountryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountryBean countryBean = CountryBean();
    countryBean.governorates = List()..addAll(
      (map['governorates'] as List ?? []).map((o) => GovernoratesBean.fromMap(o))
    );
    return countryBean;
  }

  Map toJson() => {
    "governorates": governorates,
  };
}

class GovernoratesBean {
  int id;
  String name;
  int countryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  List<CitiesBean> cities;

  static GovernoratesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GovernoratesBean governoratesBean = GovernoratesBean();
    governoratesBean.id = map['id'];
    governoratesBean.name = map['name'];
    governoratesBean.countryId = map['country_id'];
    governoratesBean.createdAt = map['created_at'];
    governoratesBean.updatedAt = map['updated_at'];
    governoratesBean.deletedAt = map['deleted_at'];
    governoratesBean.cities = List()..addAll(
      (map['cities'] as List ?? []).map((o) => CitiesBean.fromMap(o))
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

class CitiesBean {
  int id;
  String name;
  int governorateId;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  static CitiesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CitiesBean citiesBean = CitiesBean();
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