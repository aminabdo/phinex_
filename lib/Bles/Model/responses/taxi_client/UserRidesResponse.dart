import 'package:phinex/Bles/Model/responses/taxi_client/General.dart';

/// data : {"rides":[{"id":18,"user_id":"1","driver_id":null,"start_lat":"34.34","start_long":"35.4","start_location":"43","end_lat":"22","end_long":"22","end_location":"22","distance":"22","car_type_id":"1","promo_code":null,"price":"0","note":null,"duration_time":"0","rate":"0","user_rate":"5","driver_rate":"0","status":"","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":17,"user_id":"1","driver_id":null,"start_lat":"34.34","start_long":"35.4","start_location":"43","end_lat":"22","end_long":"22","end_location":"22","distance":"22","car_type_id":"1","promo_code":null,"price":"0","note":null,"duration_time":"0","rate":"0","user_rate":"5","driver_rate":"0","status":"pending","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null}]}
/// code : 200
/// message : "update success"

class UserRidesResponse {
  DataBean data;
  int code;
  String message;

  static UserRidesResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserRidesResponse userRidesResponseBean = UserRidesResponse();
    userRidesResponseBean.data = DataBean.fromMap(map['data']);
    userRidesResponseBean.code = map['code'];
    userRidesResponseBean.message = map['message'];
    return userRidesResponseBean;
  }

  Map toJson() => {
    "data": data,
    "code": code,
    "message": message,
  };
}

/// rides : [{"id":18,"user_id":"1","driver_id":null,"start_lat":"34.34","start_long":"35.4","start_location":"43","end_lat":"22","end_long":"22","end_location":"22","distance":"22","car_type_id":"1","promo_code":null,"price":"0","note":null,"duration_time":"0","rate":"0","user_rate":"5","driver_rate":"0","status":"","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":17,"user_id":"1","driver_id":null,"start_lat":"34.34","start_long":"35.4","start_location":"43","end_lat":"22","end_long":"22","end_location":"22","distance":"22","car_type_id":"1","promo_code":null,"price":"0","note":null,"duration_time":"0","rate":"0","user_rate":"5","driver_rate":"0","status":"pending","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null}]

class DataBean {
  List<Ride> rides;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.rides = List()..addAll(
      (map['rides'] as List ?? []).map((o) => Ride.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "rides": rides,
  };
}
