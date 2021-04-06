class MakeRideReplyRequest {
  String price;
  String status;
  String userId;
  String driverId;
  String userComment;
  String driverComment;
  String rideId;

  static MakeRideReplyRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MakeRideReplyRequest makeRideReplyRequestBean = MakeRideReplyRequest();
    makeRideReplyRequestBean.price = map['price'];
    makeRideReplyRequestBean.status = map['status'];
    makeRideReplyRequestBean.userId = map['user_id'];
    makeRideReplyRequestBean.driverId = map['driver_id'];
    makeRideReplyRequestBean.userComment = map['user_comment'];
    makeRideReplyRequestBean.driverComment = map['driver_comment'];
    makeRideReplyRequestBean.rideId = map['ride_id'];
    return makeRideReplyRequestBean;
  }

  Map toJson() => {
    "price": price,
    "status": status,
    "user_id": userId,
    "driver_id": driverId,
    "user_comment": userComment,
    "driver_comment": driverComment,
    "ride_id": rideId,
  };
}