import 'dart:io';

import 'package:dio/dio.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class RoomPostRequest extends BaseRequest {
  String postBody;
  int roomId;
  int postSenderId;
  File attachment;

  RoomPostRequest(
      {this.postBody, this.roomId, this.postSenderId, this.attachment});

  toJson() async {

    if(attachment == null){
      FormData formData = FormData.fromMap({
        "room_id": this.roomId,
        "user_id": this.postSenderId,
        "post_body": this.postBody,
      });
      return formData;
    }else{
      FormData formData = FormData.fromMap({
        "room_id": this.roomId,
        "user_id": this.postSenderId,
        "post_body": this.postBody,
        "attachment": await MultipartFile.fromFile(this.attachment.path),
      });
      return formData;
    }

  }
}
