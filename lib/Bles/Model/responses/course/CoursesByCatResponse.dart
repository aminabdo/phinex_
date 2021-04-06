import 'general.dart';

class CoursesByCatResponse {
  List<Courses> data;
  dynamic message;
  int code;

  static CoursesByCatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CoursesByCatResponse coursesByCatResponseBean = CoursesByCatResponse();
    coursesByCatResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Courses.fromMap(o))
    );
    coursesByCatResponseBean.message = map['message'];
    coursesByCatResponseBean.code = map['code'];
    return coursesByCatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}