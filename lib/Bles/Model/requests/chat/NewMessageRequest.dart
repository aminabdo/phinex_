import 'dart:io';

import 'package:dio/dio.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class NewMessageRequest extends BaseRequest {
  String content;
  int user_id;
  int chat_id;
  File attachment;

  NewMessageRequest(
      {this.content = "", this.user_id, this.chat_id, this.attachment});

  toJson() async {
    //print("attach path --->> "+this.attachment.path);

    if (attachment == null) {
      FormData formData = FormData.fromMap({
        "content": content,
        "user_id": user_id,
        "chat_id": chat_id,
      });
      return formData;
    } else if (attachment != null) {
      FormData formData = FormData.fromMap({
        "attachment": (await MultipartFile.fromFile(this.attachment.path)),
        "content": content,
        "user_id": user_id,
        "chat_id": chat_id,
      });
      return formData;
    }
  }
}
