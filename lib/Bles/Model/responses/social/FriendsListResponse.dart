import 'package:phinex/utils/base/BaseResponse.dart';

import 'UserProfileResponse.dart';

class FriendsListResponse extends BaseResponse {
  List<UserSocial> data;
  dynamic message;
  int code;

  static FriendsListResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FriendsListResponse friendsListResponseBean = FriendsListResponse();
    friendsListResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => UserSocial.fromMap(o))
    );
    friendsListResponseBean.message = map['message'];
    friendsListResponseBean.code = map['code'];
    return friendsListResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}