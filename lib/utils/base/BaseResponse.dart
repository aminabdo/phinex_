import 'package:dio/dio.dart';

class BaseResponse{
  dynamic message;
  int code;

  static BaseResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseResponse baseResponseBean = BaseResponse();

    baseResponseBean.message = map['message'];
    baseResponseBean.code = map['code'];
    return baseResponseBean;
  }

  Map toJson() => {
        "message": message,
        "code": code,
      };
}

class Message {
  static Map<String, dynamic> getMessageMap(List<dynamic> li) {
    Map<String, dynamic> map;
    li.forEach((element) {
      map = element;
      map.forEach((key, value) {
        List<dynamic> list = value;
        list.forEach((element) {
          print("key---> " + key + "....--->value" + element);
        });
      });
    });
    return map;
  }
}
