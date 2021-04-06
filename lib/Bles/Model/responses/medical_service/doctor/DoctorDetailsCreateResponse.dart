
import 'package:dio/dio.dart';
import 'package:phinex/utils/base/BaseResponse.dart';

class DoctorDetailsCreateResponse {
  DataBean data;
  dynamic message;
  int code;

  static DoctorDetailsCreateResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorDetailsCreateResponse doctorDetailsCreateBean = DoctorDetailsCreateResponse();
    doctorDetailsCreateBean.data = DataBean.fromMap(map['data']);
    doctorDetailsCreateBean.message = map['message'];
    doctorDetailsCreateBean.code = map['code'];
    return doctorDetailsCreateBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  CountryBean country;
  List<SpecialtyBean> specialty;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.country = CountryBean.fromMap(map['country']);
    dataBean.specialty = List()..addAll(
      (map['specialty'] as List ?? []).map((o) => SpecialtyBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "country": country,
    "specialty": specialty,
  };
}

class SpecialtyBean {
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

  static SpecialtyBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SpecialtyBean specialtyBean = SpecialtyBean();
    specialtyBean.id = map['id'];
    specialtyBean.name = map['name'];
    specialtyBean.description = map['description'];
    specialtyBean.keywords = map['keywords'];
    specialtyBean.icon = map['icon'];
    specialtyBean.parentId = map['parent_id'];
    specialtyBean.imageId = map['image_id'];
    specialtyBean.deletedAt = map['deleted_at'];
    specialtyBean.createdAt = map['created_at'];
    specialtyBean.updatedAt = map['updated_at'];
    return specialtyBean;
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