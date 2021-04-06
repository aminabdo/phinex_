

import 'package:phinex/utils/base/BaseRequest.dart';

class CourseCreateFormRequest extends BaseRequest {
  String email;
  String mobile;
  String countryId;
  String governorateId;
  String cityId;
  String categoryId;
  String instructorId;
  List<LangCourseBean> lang;

  CourseCreateFormRequest({
    this.email,
    this.mobile,
    this.countryId,
    this.governorateId,
    this.cityId,
    this.categoryId,
    this.instructorId,
    this.lang,
  });

  static CourseCreateFormRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CourseCreateFormRequest courseCreateFormRequestBean =
        CourseCreateFormRequest();
    courseCreateFormRequestBean.email = map['email'];
    courseCreateFormRequestBean.mobile = map['mobile'];
    courseCreateFormRequestBean.countryId = map['country_id'];
    courseCreateFormRequestBean.governorateId = map['governorate_id'];
    courseCreateFormRequestBean.cityId = map['city_id'];
    courseCreateFormRequestBean.categoryId = map['category_id'];
    courseCreateFormRequestBean.instructorId = map['instructor_id'];
    courseCreateFormRequestBean.lang = List()
      ..addAll(
          (map['lang'] as List ?? []).map((o) => LangCourseBean.fromMap(o)));
    return courseCreateFormRequestBean;
  }

  Map toJson() => {
        "email": email,
        "mobile": mobile,
        "country_id": countryId,
        "governorate_id": governorateId,
        "city_id": cityId,
        "category_id": categoryId,
        "instructor_id": instructorId,
        "lang": lang,
      };
}

class LangCourseBean {
  String about;
  String title;
  String description;
  String specifications;
  String lang;

  LangCourseBean(
      {this.about,
      this.title,
      this.description,
      this.specifications,
      this.lang});

  static LangCourseBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LangCourseBean langBean = LangCourseBean();
    langBean.about = map['about'];
    langBean.title = map['title'];
    langBean.description = map['description'];
    langBean.specifications = map['specifications'];
    langBean.lang = map['lang'];
    return langBean;
  }

  Map toJson() => {
        "about": about,
        "title": title,
        "description": description,
        "specifications": specifications,
        "lang": lang,
      };

  @override
  String toString() {
    return 'LangCourseBean{about: $about, title: $title, description: $description, specifications: $specifications, lang: $lang}';
  }
}
