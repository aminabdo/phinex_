
class CountriesResponse {
  List<Country> data;
  dynamic message;
  int code;

  static CountriesResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CountriesResponse countriesResponseBean = CountriesResponse();
    countriesResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Country.fromMap(o))
    );
    countriesResponseBean.message = map['message'];
    countriesResponseBean.code = map['code'];
    return countriesResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class Country {
  int id;
  String sortname;
  String name;
  int phonecode;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  static Country fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Country dataBean = Country();
    dataBean.id = map['id'];
    dataBean.sortname = map['sortname'];
    dataBean.name = map['name'];
    dataBean.phonecode = map['phonecode'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "phonecode": phonecode,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}