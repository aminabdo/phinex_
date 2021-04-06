

import 'package:phinex/utils/base/BaseRequest.dart';

class IntiateNewChatRequest extends BaseRequest {
  String title;
  int creatorId;
  List<int> users;

  IntiateNewChatRequest({this.title, this.users, this.creatorId});

  static IntiateNewChatRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IntiateNewChatRequest intaiteNewChatRequestBean = IntiateNewChatRequest();
    intaiteNewChatRequestBean.title = map['title'];
    intaiteNewChatRequestBean.creatorId = map['created_by'];
    intaiteNewChatRequestBean.users = List()
      ..addAll(
          (map['users'] as List ?? []).map((o) => int.tryParse(o.toString())));
    return intaiteNewChatRequestBean;
  }

  Map toJson() => {
        "title": title,
        "users": users,
        'created_by': creatorId,
      };

  @override
  String toString() {
    return 'IntiateNewChatRequest{title: $title, users: $users}';
  }
}
