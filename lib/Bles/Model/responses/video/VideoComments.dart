
import 'package:phinex/Bles/Model/responses/video/SingleVideoResponse.dart';

class VideoComments {
  List<CommentsBean> data;
  dynamic message;
  int code;

  VideoComments({
      this.data, 
      this.message, 
      this.code});

  VideoComments.fromJson(dynamic json) {
    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(CommentsBean.fromMap(v));
      });
    }
    message = json["message"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data.map((v) => v.toJson()).toList();
    }
    map["message"] = message;
    map["code"] = code;
    return map;
  }

}