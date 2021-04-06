import 'General.dart';

class BaseRideResponse {
  DataBean data;
  int code;
  String message;

  static BaseRideResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseRideResponse baseRideResponseBean = BaseRideResponse();
    baseRideResponseBean.data = DataBean.fromMap(map['data']);
    baseRideResponseBean.code = map['code'];
    baseRideResponseBean.message = map['message'];
    return baseRideResponseBean;
  }

  Map toJson() => {
    "data": data,
    "code": code,
    "message": message,
  };
}

class DataBean {
  Ride ride;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.ride = Ride.fromMap(map['ride']);
    return dataBean;
  }

  Map toJson() => {
    "ride": ride,
  };
}


