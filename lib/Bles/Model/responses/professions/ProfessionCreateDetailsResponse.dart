class ProfessionCreateDetailsResponse {
  DataBean data;
  dynamic message;
  int code;

  static ProfessionCreateDetailsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfessionCreateDetailsResponse professionCreateDetailsResponseBean = ProfessionCreateDetailsResponse();
    professionCreateDetailsResponseBean.data = DataBean.fromMap(map['data']);
    professionCreateDetailsResponseBean.message = map['message'];
    professionCreateDetailsResponseBean.code = map['code'];
    return professionCreateDetailsResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  CountryBean country;
  List<CategoriesBean> categories;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.country = CountryBean.fromMap(map['country']);
    dataBean.categories = List()..addAll(
      (map['categories'] as List ?? []).map((o) => CategoriesBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "country": country,
    "categories": categories,
  };
}

class CategoriesBean {
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

  static CategoriesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesBean categoriesBean = CategoriesBean();
    categoriesBean.id = map['id'];
    categoriesBean.name = map['name'];
    categoriesBean.description = map['description'];
    categoriesBean.keywords = map['keywords'];
    categoriesBean.icon = map['icon'];
    categoriesBean.parentId = map['parent_id'];
    categoriesBean.imageId = map['image_id'];
    categoriesBean.deletedAt = map['deleted_at'];
    categoriesBean.createdAt = map['created_at'];
    categoriesBean.updatedAt = map['updated_at'];
    return categoriesBean;
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