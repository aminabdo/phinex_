

import 'package:phinex/utils/base/BaseRequest.dart';

class JobAddRequest extends BaseRequest{
  String email;
  String mobile;
  String countryId;
  String governorateId;
  String cityId;
  String categoryId;
  String recruiterId;
  String type;
  List<LangBean> lang;

  static JobAddRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JobAddRequest jobAddRequestBean = JobAddRequest();
    jobAddRequestBean.email = map['email'];
    jobAddRequestBean.mobile = map['mobile'];
    jobAddRequestBean.countryId = map['country_id'];
    jobAddRequestBean.governorateId = map['governorate_id'];
    jobAddRequestBean.cityId = map['city_id'];
    jobAddRequestBean.categoryId = map['category_id'];
    jobAddRequestBean.recruiterId = map['recruiter_id'];
    jobAddRequestBean.type = map['type'];
    jobAddRequestBean.lang = List()..addAll(
      (map['lang'] as List ?? []).map((o) => LangBean.fromMap(o))
    );
    return jobAddRequestBean;
  }

  Map toJson() => {
    "email": email,
    "mobile": mobile,
    "country_id": countryId,
    "governorate_id": governorateId,
    "city_id": cityId,
    "category_id": categoryId,
    "recruiter_id": recruiterId,
    "type": type,
    "lang": lang,
  };
}
class LangBean {
  String about;
  String title;
  String description;
  String requirements;
  String lang;

  static LangBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangBean langBean = LangBean();
    langBean.about = map['about'];
    langBean.title = map['title'];
    langBean.description = map['description'];
    langBean.requirements = map['requirements'];
    langBean.lang = map['lang'];
    return langBean;
  }

  Map toJson() => {
    "about": about,
    "title": title,
    "description": description,
    "requirements": requirements,
    "lang": lang,
  };
}