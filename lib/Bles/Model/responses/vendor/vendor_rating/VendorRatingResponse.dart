import 'package:phinex/Bles/Model/responses/vendor/vendor_by_id/RatingBean.dart';
import 'package:phinex/utils/base/BaseResponse.dart';

class VendorRatingResponse extends BaseResponse{
  List<RatingBean> data;


  static VendorRatingResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VendorRatingResponse vendorRatingResponseBean = VendorRatingResponse();
    vendorRatingResponseBean.data = List()..addAll(
      (map['data'] as List ?? []).map((o) => RatingBean.fromMap(o))
    );
    vendorRatingResponseBean.message = map['message'];
    vendorRatingResponseBean.code = map['code'];
    return vendorRatingResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}


class UserBean {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  dynamic imageUrl;

  static UserBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserBean userBean = UserBean();
    userBean.id = map['id'];
    userBean.firstName = map['first_name'];
    userBean.lastName = map['last_name'];
    userBean.username = map['username'];
    userBean.phone = map['phone'];
    userBean.verificationCode = map['verification_code'];
    userBean.apiToken = map['api_token'];
    userBean.phoneVerifiedAt = map['phone_verified_at'];
    userBean.type = map['type'];
    userBean.chanel = map['chanel'];
    userBean.imageUrl = map['image_url'];
    return userBean;
  }

  Map toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "phone": phone,
    "verification_code": verificationCode,
    "api_token": apiToken,
    "phone_verified_at": phoneVerifiedAt,
    "type": type,
    "chanel": chanel,
    "image_url": imageUrl,
  };
}