import 'General.dart';

/// data : {"RideRequests":[{"id":1,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":2,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":3,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null}]}
/// code : 200
/// message : "update success"

class ShowRideReplyByRide {
  DataBean data;
  int code;
  String message;

  static ShowRideReplyByRide fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ShowRideReplyByRide showRideRequestsByRideBean = ShowRideReplyByRide();
    showRideRequestsByRideBean.data = DataBean.fromMap(map['data']);
    showRideRequestsByRideBean.code = map['code'];
    showRideRequestsByRideBean.message = map['message'];
    return showRideRequestsByRideBean;
  }

  Map toJson() => {
    "data": data,
    "code": code,
    "message": message,
  };
}

/// RideRequests : [{"id":1,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":2,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null},{"id":3,"user_id":"1","driver_id":"1","start_lat":null,"start_long":null,"start_location":null,"end_lat":null,"end_long":null,"end_location":null,"distance":null,"car_type_id":null,"promo_code":null,"price":"900","note":null,"duration_time":null,"rate":null,"user_rate":null,"driver_rate":null,"status":"new","pick_time":null,"code":null,"payment_method":null,"type":null,"date":null,"time":null}]

class DataBean {
  List<RideRequest> RideRequests;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.RideRequests = List()..addAll(
      (map['RideRequests'] as List ?? []).map((o) => RideRequest.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "RideRequests": RideRequests,
  };
}

