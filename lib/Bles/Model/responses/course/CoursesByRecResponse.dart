import 'general.dart';


class CoursesByRecResponse {
  List<Courses> data;
  dynamic message;
  int code;

  static CoursesByRecResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CoursesByRecResponse coursesByRecResponseBean = CoursesByRecResponse();
    coursesByRecResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Courses.fromMap(o))
    );
    coursesByRecResponseBean.message = map['message'];
    coursesByRecResponseBean.code = map['code'];
    return coursesByRecResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}