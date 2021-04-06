class UserRateRequest {
  int userId;
  int id;
  int user_rate;

  static UserRateRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserRateRequest changeRideStatusRequestBean = UserRateRequest();
    changeRideStatusRequestBean.userId = map['user_id'];
    changeRideStatusRequestBean.id = map['id'];
    changeRideStatusRequestBean.user_rate = map['user_rate'];
    return changeRideStatusRequestBean;
  }

  Map toJson() => {
    "user_id": userId,
    "id": id,
    "status": user_rate,
  };
}