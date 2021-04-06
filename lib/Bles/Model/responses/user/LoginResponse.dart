import 'package:phinex/Bles/Model/responses/store/single_product/UserBean.dart';

class LoginResponse {
  DataBean data;
  dynamic message;
  int code;

  static LoginResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LoginResponse loginResponseBean = LoginResponse();
    loginResponseBean.data = DataBean.fromMap(map['data']);
    loginResponseBean.message = map['message'];
    loginResponseBean.code = map['code'];
    return loginResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  UserData user;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.user = UserData.fromMap(map['user']);
    return dataBean;
  }

  Map toJson() => {
    "user": user,
  };
}