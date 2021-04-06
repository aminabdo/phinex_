import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/ClinicLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonPaginResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonSingleResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class CommonApiProvider extends BaseApiProvider {

  Future<CommonPaginResponse> getCommonLanding(String objName) async {
    try {

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.commonLanding(objName)),
          options: options);

      print("CommonSingleResponse ---> Response");
      print(CommonPaginResponse.fromMap(response.data).toJson());

      return CommonPaginResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CommonSingleResponse> getCommonSingle(int id , String objName) async {
    try {
      print("CommonSingleResponse request --->"+ApiRoutesUpdate().getLink(ApiRoutes.commonSingle(id, objName)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.commonSingle(id, objName)),
          options: options);

      print("CommonSingleResponse ---> Response");
      print(CommonSingleResponse.fromMap(response.data).toJson());
      return CommonSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CommonPaginResponse> getCommonPagin(BaseRequestSkipTake request , String objName) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.commonPagin(request, objName)),
          options: options);

      print("CommonPaginResponse ---> Response");
      print(response.data);
      return CommonPaginResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ClinicLandingResponse> getClinicLanding(String objName) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.commonLanding(objName)),
          options: options);

      return ClinicLandingResponse.fromMap(response.data);

    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


  Future<Response> bookNow(BookNowRequest request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.commonBookNow),
          options: options ,data: request.toJson());

      print(response.data);

      return response;

    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}