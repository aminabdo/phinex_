import 'IntiateNewChatResponse.dart';

class ChatInfoResponse {
  Chat data;
  dynamic message;
  int code;

  static ChatInfoResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChatInfoResponse chatInfoResponseBean = ChatInfoResponse();
    chatInfoResponseBean.data = Chat.fromMap(map['data']);
    chatInfoResponseBean.message = map['message'];
    chatInfoResponseBean.code = map['code'];
    return chatInfoResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

