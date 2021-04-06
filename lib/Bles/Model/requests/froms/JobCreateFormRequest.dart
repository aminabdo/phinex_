import 'dart:io';

import 'package:phinex/utils/base/BaseRequest.dart';
import 'package:phinex/utils/consts.dart';

class JobCreateFormRequest extends BaseRequest {
  String _email;
  String _mobile;
  String _countryId;
  String _governorateId;
  String _cityId;
  String _address;
  String _careerLevel;
  String _categoryId;
  String _type;
  List<JobLang> _lang;
  File _image;

  String get email => _email;

  String get mobile => _mobile;

  String get countryId => _countryId;

  String get governorateId => _governorateId;

  String get cityId => _cityId;

  String get address => _address;

  String get careerLevel => _careerLevel;

  String get categoryId => _categoryId;

  String get type => _type;

  List<JobLang> get lang => _lang;

  File get image => _image;

  JobCreateFormRequest({
    String email,
    String mobile,
    String countryId,
    String governorateId,
    String cityId,
    String address,
    String careerLevel,
    String categoryId,
    String type,
    List<JobLang> lang,
    File image,
  }) {
    _email = email;
    _mobile = mobile;
    _countryId = countryId;
    _governorateId = governorateId;
    _cityId = cityId;
    _address = address;
    _careerLevel = careerLevel;
    _categoryId = categoryId;
    _type = type;
    _lang = lang;
    _image = image;
  }

  JobCreateFormRequest.fromJson(dynamic json) {
    _email = json["email"];
    _mobile = json["mobile"];
    _countryId = json["country_id"];
    _governorateId = json["governorate_id"];
    _cityId = json["city_id"];
    _address = json["address"];
    _careerLevel = json["careerLevel"];
    _categoryId = json["category_id"];
    _type = json["type"];
    if (json["lang"] != null) {
      _lang = [];
      json["lang"].forEach((v) {
        _lang.add(JobLang.fromJson(v));
      });
    }
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["country_id"] = _countryId;
    map["governorate_id"] = _governorateId;
    map["city_id"] = _cityId;
    map["address"] = _address;
    map["careerLevel"] = _careerLevel;
    map["category_id"] = _categoryId;
    map["type"] = _type;
    if (_lang != null) {
      map["lang"] = _lang.map((v) => v.toJson()).toList();
    }
    map["image"] = imageToString(_image);
    return map;
  }
}

class JobLang {
  String _about;
  String _title;
  String _description;
  String _requirements;
  String _lang;

  String get about => _about;

  String get title => _title;

  String get description => _description;

  String get requirements => _requirements;

  String get lang => _lang;

  set about(String value) {
    _about = value;
  }

  JobLang({
    String about,
    String title,
    String description,
    String requirements,
    String lang,
  }) {
    _about = about;
    _title = title;
    _description = description;
    _requirements = requirements;
    _lang = lang;
  }

  JobLang.fromJson(dynamic json) {
    _about = json["about"];
    _title = json["title"];
    _description = json["description"];
    _requirements = json["requirements"];
    _lang = json["lang"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["about"] = _about;
    map["title"] = _title;
    map["description"] = _description;
    map["requirements"] = _requirements;
    map["lang"] = _lang;
    return map;
  }

  set title(String value) {
    _title = value;
  }

  set description(String value) {
    _description = value;
  }

  set requirements(String value) {
    _requirements = value;
  }

  set lang(String value) {
    _lang = value;
  }
}
