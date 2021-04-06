import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/SignupRequest.dart';
import 'package:phinex/Bles/Model/requests/user/LoginRequest.dart';
import 'package:phinex/Bles/Model/responses/user/LoginResponse.dart';
import 'package:phinex/Bles/Model/responses/user/SignupResponse.dart';
import 'package:phinex/Bles/Repository/UserRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class AuthBloc extends BaseBloc {
  final AuthRepository _repository = AuthRepository();
  BehaviorSubject<SignupResponse> _signupSubject =
      BehaviorSubject<SignupResponse>();
  BehaviorSubject<LoginResponse> _loginSubject =
      BehaviorSubject<LoginResponse>();

  signup(SignupRequest signupRequest) async {
    loading.value = true;
    SignupResponse response = await _repository.signup(signupRequest);
    _signupSubject.value = response;
    loading.value = false;
  }

  Future<LoginResponse> login(LoginRequest request) async {
    loading.value = true;
    LoginResponse response =  await _repository.login(request);
    _loginSubject.value = response;

    loading.value = false;
    return response;
  }

  Future<Response> verifyOTP(String phone, String otp) async {
    var response = await repository.get(ApiRoutes.verifyOTP(phone, otp));
    return response;
  }

  Future<Response> resendOtp(int userId) async {
    var response = await repository.get(ApiRoutes.resendOTP(userId));
    return response;
  }

  Future<Response> forgotPassword(String phone) async {
    var response = await repository.post(ApiRoutes.forgotPassword(), {"phone":'$phone'.trim()});
    return response;
  }

  Future<Response> verifyPhoneForgetPassword(String otp, String userId) async {
    var response = await repository.get(ApiRoutes.verifyPhoneForgetPassword(otp, userId),);
    return response;
  }

  dispose() {
    super.dispose();
    _signupSubject.close();
    _loginSubject.close();
  }

  clear() {
    super.clear();
    _signupSubject = BehaviorSubject<SignupResponse>();
    _loginSubject = BehaviorSubject<LoginResponse>();
  }

  BehaviorSubject<SignupResponse> get signupSubject => _signupSubject;

  BehaviorSubject<LoginResponse> get loginSubject => _loginSubject;
}

final authBloc = AuthBloc();
