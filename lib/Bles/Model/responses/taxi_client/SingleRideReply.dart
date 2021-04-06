import 'General.dart';

/// data : {"RideRequest":{"id":1,"price":"900","status":"new","user_id":"1","driver_id":"1","user_comment":"test","driver_comment":"test","ride_id":"1","created_at":"2020-12-28 00:24:07","updated_at":"2020-12-28 00:24:07"}}
/// code : 200
/// message : "update success"

class SingleRideReply {
  DataBean data;
  int code;
  String message;

  static SingleRideReply fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SingleRideReply singleRideRequestBean = SingleRideReply();
    singleRideRequestBean.data = DataBean.fromMap(map['data']);
    singleRideRequestBean.code = map['code'];
    singleRideRequestBean.message = map['message'];
    return singleRideRequestBean;
  }

  Map toJson() => {
    "data": data,
    "code": code,
    "message": message,
  };
}

/// RideRequest : {"id":1,"price":"900","status":"new","user_id":"1","driver_id":"1","user_comment":"test","driver_comment":"test","ride_id":"1","created_at":"2020-12-28 00:24:07","updated_at":"2020-12-28 00:24:07"}

class DataBean {
  Ride_replyBean rideRequest;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.rideRequest = Ride_replyBean.fromMap(map['RideRequest']);
    return dataBean;
  }

  Map toJson() => {
    "RideRequest": rideRequest,
  };
}

/// id : 1
/// price : "900"
/// status : "new"
/// user_id : "1"
/// driver_id : "1"
/// user_comment : "test"
/// driver_comment : "test"
/// ride_id : "1"
/// created_at : "2020-12-28 00:24:07"
/// updated_at : "2020-12-28 00:24:07"

