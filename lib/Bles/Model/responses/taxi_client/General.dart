
class VehicleType {
  int id;
  String title;
  String image;
  String createdAt;
  String updatedAt;

  static VehicleType fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VehicleType dataBean = VehicleType();
    dataBean.id = map['id'];
    dataBean.title = map['title'];
    dataBean.image = map['image'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    return dataBean;
  }

  Map toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class RideRequest {
  int id;
  String price;
  String status;
  String userId;
  String driverId;
  String userComment;
  String driverComment;
  String rideId;
  String createdAt;
  String updatedAt;

  static RideRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RideRequest rideRequestBean = RideRequest();
    rideRequestBean.id = map['id'];
    rideRequestBean.price = map['price'];
    rideRequestBean.status = map['status'];
    rideRequestBean.userId = map['user_id'];
    rideRequestBean.driverId = map['driver_id'];
    rideRequestBean.userComment = map['user_comment'];
    rideRequestBean.driverComment = map['driver_comment'];
    rideRequestBean.rideId = map['ride_id'];
    rideRequestBean.createdAt = map['created_at'];
    rideRequestBean.updatedAt = map['updated_at'];
    return rideRequestBean;
  }

  Map toJson() => {
    "id": id,
    "price": price,
    "status": status,
    "user_id": userId,
    "driver_id": driverId,
    "user_comment": userComment,
    "driver_comment": driverComment,
    "ride_id": rideId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Ride {
  int id;
  dynamic userId;
  dynamic driverId;
  String startLat;
  String startLong;
  String startLocation;
  String endLat;
  String endLong;
  String endLocation;
  String distance;
  String carTypeId;
  dynamic promoCode;
  String price;
  dynamic note;
  String durationTime;
  String rate;
  String userRate;
  String driverRate;
  String status;
  dynamic pickTime;
  dynamic code;
  dynamic paymentMethod;
  dynamic type;
  dynamic date;
  dynamic time;
  List<Ride_replyBean> rideReply;

  static Ride fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Ride rideBean = Ride();
    rideBean.id = map['id'];
    rideBean.userId = map['user_id'];
    rideBean.driverId = map['driver_id'];
    rideBean.startLat = map['start_lat'];
    rideBean.startLong = map['start_long'];
    rideBean.startLocation = map['start_location'];
    rideBean.endLat = map['end_lat'];
    rideBean.endLong = map['end_long'];
    rideBean.endLocation = map['end_location'];
    rideBean.distance = map['distance'];
    rideBean.carTypeId = map['car_type_id'];
    rideBean.promoCode = map['promo_code'];
    rideBean.price = map['price'];
    rideBean.note = map['note'];
    rideBean.durationTime = map['duration_time'];
    rideBean.rate = map['rate'];
    rideBean.userRate = map['user_rate'];
    rideBean.driverRate = map['driver_rate'];
    rideBean.status = map['status'];
    rideBean.pickTime = map['pick_time'];
    rideBean.code = map['code'];
    rideBean.paymentMethod = map['payment_method'];
    rideBean.type = map['type'];
    rideBean.date = map['date'];
    rideBean.time = map['time'];
    rideBean.rideReply = List()..addAll(
        (map['ride_reply'] as List ?? []).map((o) => Ride_replyBean.fromMap(o))
    );
    return rideBean;
  }

  Map toJson() => {
    "id": id,
    "user_id": userId,
    "driver_id": driverId,
    "start_lat": startLat,
    "start_long": startLong,
    "start_location": startLocation,
    "end_lat": endLat,
    "end_long": endLong,
    "end_location": endLocation,
    "distance": distance,
    "car_type_id": carTypeId,
    "promo_code": promoCode,
    "price": price,
    "note": note,
    "duration_time": durationTime,
    "rate": rate,
    "user_rate": userRate,
    "driver_rate": driverRate,
    "status": status,
    "pick_time": pickTime,
    "code": code,
    "payment_method": paymentMethod,
    "type": type,
    "date": date,
    "time": time,
    "ride_reply": rideReply,
  };
}

class Ride_replyBean {
  int id;
  String price;
  String status;
  dynamic userId;
  String driverId;
  String userComment;
  String driverComment;
  String rideId;
  String createdAt;
  String updatedAt;

  static Ride_replyBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Ride_replyBean ride_replyBean = Ride_replyBean();
    ride_replyBean.id = map['id'];
    ride_replyBean.price = map['price'];
    ride_replyBean.status = map['status'];
    ride_replyBean.userId = map['user_id'];
    ride_replyBean.driverId = map['driver_id'];
    ride_replyBean.userComment = map['user_comment'];
    ride_replyBean.driverComment = map['driver_comment'];
    ride_replyBean.rideId = map['ride_id'];
    ride_replyBean.createdAt = map['created_at'];
    ride_replyBean.updatedAt = map['updated_at'];
    return ride_replyBean;
  }


  static Ride_replyBean fromList(List<dynamic> list) {
    if (list == null) return null;
    else{
      Map<String, dynamic> map = list.first;
      Ride_replyBean ride_replyBean = Ride_replyBean();
      ride_replyBean.id = map['id'];
      ride_replyBean.price = map['price'];
      ride_replyBean.status = map['status'];
      ride_replyBean.userId = map['user_id'];
      ride_replyBean.driverId = map['driver_id'];
      ride_replyBean.userComment = map['user_comment'];
      ride_replyBean.driverComment = map['driver_comment'];
      ride_replyBean.rideId = map['ride_id'];
      ride_replyBean.createdAt = map['created_at'];
      ride_replyBean.updatedAt = map['updated_at'];
      return ride_replyBean;
    }
  }



  Map toJson() => {
    "id": id,
    "price": price,
    "status": status,
    "user_id": userId,
    "driver_id": driverId,
    "user_comment": userComment,
    "driver_comment": driverComment,
    "ride_id": rideId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

//
// class RideReply {
//   int id;
//   String price;
//   String status;
//   String userId;
//   String driverId;
//   String userComment;
//   String driverComment;
//   String rideId;
//   String createdAt;
//   String updatedAt;
//
//   static RideReply fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//     RideReply testBean = RideReply();
//     testBean.id = map['id'];
//     testBean.price = map['price'];
//     testBean.status = map['status'];
//     testBean.userId = map['user_id'];
//     testBean.driverId = map['driver_id'];
//     testBean.userComment = map['user_comment'];
//     testBean.driverComment = map['driver_comment'];
//     testBean.rideId = map['ride_id'];
//     testBean.createdAt = map['created_at'];
//     testBean.updatedAt = map['updated_at'];
//     return testBean;
//   }
//
//
//   Map toJson() => {
//     "id": id,
//     "price": price,
//     "status": status,
//     "user_id": userId,
//     "driver_id": driverId,
//     "user_comment": userComment,
//     "driver_comment": driverComment,
//     "ride_id": rideId,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
//
//   @override
//   String toString() {
//     return 'RideReply{id: $id, price: $price, status: $status, userId: $userId, driverId: $driverId, userComment: $userComment, driverComment: $driverComment, rideId: $rideId, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }
