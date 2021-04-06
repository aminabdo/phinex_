import 'UserProfileResponse.dart';

class ShowFriendShipRequestsResponse {
  List<UserSocial> data;
  dynamic message;
  int code;

  static ShowFriendShipRequestsResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ShowFriendShipRequestsResponse showFriendShipRequestsResponseBean = ShowFriendShipRequestsResponse();
    showFriendShipRequestsResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => UserSocial.fromMap(o))
    );
    showFriendShipRequestsResponseBean.message = map['message'];
    showFriendShipRequestsResponseBean.code = map['code'];
    return showFriendShipRequestsResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

