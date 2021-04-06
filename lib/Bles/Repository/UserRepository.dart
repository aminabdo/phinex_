

import 'package:phinex/Bles/Model/requests/SignupRequest.dart';
import 'package:phinex/Bles/Model/requests/user/LoginRequest.dart';
import 'package:phinex/Bles/Model/responses/user/LoginResponse.dart';
import 'package:phinex/Bles/Model/responses/user/SignupResponse.dart';
import 'package:phinex/Bles/api_provider/user/UserApiProvider.dart';

class AuthRepository {
  AuthApiProvider _apiProvider = AuthApiProvider();

  Future<SignupResponse> signup(SignupRequest signupRequest) {
    return _apiProvider.signup(signupRequest);
  }

  Future<LoginResponse> login(LoginRequest loginRequest) {
    return _apiProvider.login(loginRequest);
  }
}
