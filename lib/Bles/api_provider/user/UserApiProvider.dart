import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/SignupRequest.dart';
import 'package:phinex/Bles/Model/requests/user/LoginRequest.dart';
import 'package:phinex/Bles/Model/responses/user/LoginResponse.dart';
import 'package:phinex/Bles/Model/responses/user/SignupResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class AuthApiProvider extends BaseApiProvider {
  Future<SignupResponse> signup(SignupRequest signupRequest) async {
    try {
      formData = new FormData.fromMap(signupRequest.toJson());
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.registeration));

      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.registeration),
          data: formData,
          options: options);

      print("99999 === >>> " + signupRequest.toJson().toString());
      // final Map parsed = json.decode(response.data);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("if ----->");
        SignupResponse signupResponse = SignupResponse.fromMap(response.data);
        print("response data --->" + signupResponse.data.toString());
        print("response message --->" + signupResponse.message.toString());
        print("response code --->" + signupResponse.code.toString());

        return signupResponse;
      } else {
        print("else ----->");
        SignupResponse signupResponse = SignupResponse.fromMap(response.data);

        print(signupResponse.toString());
        return signupResponse;
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      formData = new FormData.fromMap(loginRequest.toJson());
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.login));

      Response response = await dio.post(
        ApiRoutesUpdate().getLink(ApiRoutes.login),
        data: formData,
        options: options,
      );

      print("99999 === >>> " + loginRequest.toJson().toString());

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("if ----->");
        LoginResponse loginResponse = LoginResponse.fromMap(response.data);
        print("response data --->" + loginResponse.data.toString());
        print("response message --->" + loginResponse.message.toString());
        print("response code --->" + loginResponse.code.toString());

        return loginResponse;
      } else {
        print("else ----->");
        LoginResponse loginResponse = LoginResponse.fromMap(response.data);

        print(loginResponse.toString());
        return loginResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
