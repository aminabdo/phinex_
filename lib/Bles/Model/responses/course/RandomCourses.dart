import 'general.dart';


class RandomCourses {
  List<Courses> data;
  dynamic message;
  int code;

  static RandomCourses fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RandomCourses randomcoursesBean = RandomCourses();
    randomcoursesBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Courses.fromMap(o))
    );
    randomcoursesBean.message = map['message'];
    randomcoursesBean.code = map['code'];
    return randomcoursesBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
