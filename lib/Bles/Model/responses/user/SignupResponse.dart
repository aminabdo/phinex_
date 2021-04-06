import 'package:phinex/utils/base/BaseResponse.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/UserBean.dart';

class SignupResponse extends BaseResponse {
  UserData data;

  static SignupResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SignupResponse registrationResponseBean = SignupResponse();
    registrationResponseBean.data = UserData.fromMap(map['data']);
    registrationResponseBean.message = map['message'];
    registrationResponseBean.code = map['code'];
    return registrationResponseBean;
  }

  Map toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}

//
//   class UserResponse {
//   String firstName;
//   String lastName;
//   String username;
//   String phone;
//   String apiToken;
//   String type;
//   String chanel;
//   int verificationCode;
//   int id;
//   String test ;
//
//   static UserResponse fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;
//     UserResponse userResponse = UserResponse();
//     userResponse.firstName = map['first_name'];
//     userResponse.lastName = map['last_name'];
//     userResponse.username = map['username'];
//     userResponse.phone = map['phone'];
//     userResponse.apiToken = map['api_token'];
//     userResponse.type = map['type'];
//     userResponse.chanel = map['chanel'];
//     userResponse.verificationCode = map['verification_code'];
//     userResponse.id = map['id'];
//     userResponse.test = map['test'];
//     return userResponse;
//   }
//   Map toJson() => {
//     "first_name": firstName,
//     "last_name": lastName,
//     "username": username,
//     "phone": phone,
//     "api_token": apiToken,
//     "type": type,
//     "chanel": chanel,
//     "verification_code": verificationCode,
//     "id": id,
//     "test": test,
//   };
// }
