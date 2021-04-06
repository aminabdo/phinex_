import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBookNowResponse.dart';

class NewMessageToChatResponse {
  DataBean data;
  dynamic message;
  int code;

  static NewMessageToChatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NewMessageToChatResponse newMessageToChatResponseBean = NewMessageToChatResponse();
    newMessageToChatResponseBean.data = DataBean.fromMap(map['data']);
    newMessageToChatResponseBean.message = map['message'];
    newMessageToChatResponseBean.code = map['code'];
    return newMessageToChatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  Messages message;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.message = Messages.fromMap(map['message']);
    return dataBean;
  }

  Map toJson() => {
    "message": message,
  };
}

