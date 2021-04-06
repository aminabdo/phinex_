import 'package:phinex/utils/base/BaseResponse.dart';

/// data : {"datetime":"2020-12-12 00:00:01.000000","doctor_id":"1","notes":"1","user_id":"1","clinic_id":"1","updated_at":"2020-12-03T14:39:55.000000Z","created_at":"2020-12-03T14:39:55.000000Z","id":11}
/// message : [{"user_id":["The user id field is required."]},{"doctor_id":["The doctor id field is required."]},{"clinic_id":["The clinic id field is required."]}]
/// code : 422

class DoctorBookNowResponse {
  DataBean data;
  List<MessageBean> message;
  int code;

  static DoctorBookNowResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DoctorBookNowResponse doctorBookNowResponseBean = DoctorBookNowResponse();
    doctorBookNowResponseBean.data = DataBean.fromMap(map['data']);
    doctorBookNowResponseBean.message = List()..addAll(
      (map['message'] as List ?? []).map((o) => MessageBean.fromMap(o))
    );
    doctorBookNowResponseBean.code = map['code'];
    return doctorBookNowResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class MessageBean {
  List<String> userId;

  static MessageBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MessageBean messageBean = MessageBean();
    messageBean.userId = List()..addAll(
      (map['user_id'] as List ?? []).map((o) => o.toString())
    );
    return messageBean;
  }

  Map toJson() => {
    "user_id": userId,
  };
}


class DataBean {
  String datetime;
  String doctorId;
  String notes;
  String userId;
  String clinicId;
  String updatedAt;
  String createdAt;
  int id;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.datetime = map['datetime'];
    dataBean.doctorId = map['doctor_id'];
    dataBean.notes = map['notes'];
    dataBean.userId = map['user_id'];
    dataBean.clinicId = map['clinic_id'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.createdAt = map['created_at'];
    dataBean.id = map['id'];
    return dataBean;
  }

  Map toJson() => {
    "datetime": datetime,
    "doctor_id": doctorId,
    "notes": notes,
    "user_id": userId,
    "clinic_id": clinicId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}