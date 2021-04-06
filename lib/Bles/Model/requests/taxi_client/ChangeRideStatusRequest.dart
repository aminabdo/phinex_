/// user_id : 1
/// id : 1
/// status : "test"

class ChangeRideStatusRequest {
  int userId;
  int id;
  String status;
  String user_comment;

  ChangeRideStatusRequest({this.userId, this.id, this.status,this.user_comment});

  static ChangeRideStatusRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChangeRideStatusRequest changeRideStatusRequestBean = ChangeRideStatusRequest();
    changeRideStatusRequestBean.userId = map['user_id'];
    changeRideStatusRequestBean.id = map['id'];
    changeRideStatusRequestBean.status = map['status'];
    changeRideStatusRequestBean.user_comment = map['user_comment'];
    return changeRideStatusRequestBean;
  }

  Map toJson() => {
    "user_id": userId,
    "id": id,
    "status": status,
    "user_comment": user_comment,
  };
}