class MakeRideRequest {
  String userId;
  String startLat;
  String startLong;
  String startLocation;
  String endLat;
  String endLong;
  String endLocation;
  String distance;
  String carTypeId;

  MakeRideRequest(
      {this.userId,
      this.startLat,
      this.startLong,
      this.startLocation,
      this.endLat,
      this.endLong,
      this.endLocation,
      this.distance,
      this.carTypeId});

  static MakeRideRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MakeRideRequest makeRideRequestBean = MakeRideRequest();
    makeRideRequestBean.userId = map['user_id'];
    makeRideRequestBean.startLat = map['start_lat'];
    makeRideRequestBean.startLong = map['start_long'];
    makeRideRequestBean.startLocation = map['start_location'];
    makeRideRequestBean.endLat = map['end_lat'];
    makeRideRequestBean.endLong = map['end_long'];
    makeRideRequestBean.endLocation = map['end_location'];
    makeRideRequestBean.distance = map['distance'];
    makeRideRequestBean.carTypeId = map['car_type_id'];
    return makeRideRequestBean;
  }

  Map toJson() => {
        "user_id": userId,
        "start_lat": startLat,
        "start_long": startLong,
        "start_location": startLocation,
        "end_lat": endLat,
        "end_long": endLong,
        "end_location": endLocation,
        "distance": distance,
        "car_type_id": carTypeId,
      };
}
