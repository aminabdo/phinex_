import 'UserProfileResponse.dart';

class SearchUserResponse {
  List<UserSocial> data;
  dynamic message;
  int code;

  static SearchUserResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SearchUserResponse searchUserResponseBean = SearchUserResponse();
    searchUserResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => UserSocial.fromMap(o))
    );
    searchUserResponseBean.message = map['message'];
    searchUserResponseBean.code = map['code'];
    return searchUserResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

