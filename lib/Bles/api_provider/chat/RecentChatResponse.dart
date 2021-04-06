
import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';

class RecentChatResponse {
  List<Chat> data;
  dynamic message;
  int code;

  static RecentChatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RecentChatResponse recentChatResponseBean = RecentChatResponse();
    recentChatResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => Chat.fromMap(o))
    );
    recentChatResponseBean.message = map['message'];
    recentChatResponseBean.code = map['code'];
    return recentChatResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
