import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';

class MessageByChatResponse {
  DataBean data;
  dynamic message;
  int code;

  static MessageByChatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MessageByChatResponse messageByChatResponseBean = MessageByChatResponse();
    messageByChatResponseBean.data = DataBean.fromMap(map['data']);
    messageByChatResponseBean.message = map['message'];
    messageByChatResponseBean.code = map['code'];
    return messageByChatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  List<Messages> messages;
  Chat chat;
  List<Subscriptions> members;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.messages = List()..addAll(
      (map['messages'] as List ?? []).map((o) => Messages.fromMap(o))
    );
    dataBean.chat = Chat.fromMap(map['chat']);

    dataBean.members = List()..addAll(
      (map['members'] as List ?? []).map((o) => Subscriptions.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "messages": messages,
    "chat": chat,
    "members": members,
  };
}
