import 'general.dart';


class CourseSingleResponse {
  Courses data;
  dynamic message;
  int code;

  static CourseSingleResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CourseSingleResponse courseSingleResponseBean = CourseSingleResponse();
    courseSingleResponseBean.data = Courses.fromMap(map['data']);
    courseSingleResponseBean.message = map['message'];
    courseSingleResponseBean.code = map['code'];
    return courseSingleResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
