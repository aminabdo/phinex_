import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';

class TestResponse {
  Messages message;
  String chat;
  dynamic sender;

  static TestResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TestResponse testResponseBean = TestResponse();
    testResponseBean.message = Messages.fromMap(map['message']);
    testResponseBean.chat = map['chat'];
    testResponseBean.sender = map['sender'];
    return testResponseBean;
  }

  Map toJson() => {
    "message": message,
    "chat": chat,
    "sender": sender,
  };
}