import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/base/BasePostResponse.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../ApiRoutes.dart';

class BaseApiProvider {
  String baseUrl = "";
  String token = "";

  Options get options => Options(
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: {
          'Authorization': AppUtils.userData?.token?.trim() ?? '',
          'content-type': 'application/x-www-form-urlencoded'
        },
      );


  Dio dio = Dio();

  FormData formData;

  void printe(Response response) {
    if (response == null) {
      print("null response");
    } else {
      print("response message " + response.statusMessage);
      print("response message " + response.statusCode.toString());
    }
  }

  Future<Response> generalGet(String urlExtension) async {
    try {
      Response response = await dio.get(
        ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtension)),
        options: options,
      );

      print(response);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalDelete(String urlExtention) async {
    try {
      Response response = await dio.delete(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options);

      print(response);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPost(
      String urlExtention, Map<dynamic, dynamic> request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options,
          data: request, onSendProgress: (int sent, int total) {
        print("$sent $total");
      });
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPost2(
      String urlExtention, Map<dynamic, dynamic> request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink2(ApiRoutes.generalGet(urlExtention)),
          options: options,
          data: request, onSendProgress: (int sent, int total) {
        print("$sent $total");
      });
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPostUpload(
      String urlExtention, FormData request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options,
          data: request, onSendProgress: (int sent, int total) {
        print("$sent $total");
      });
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPut(
      String urlExtention, Map<dynamic, dynamic> request) async {
    try {
      Response response = await dio.put(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options,
          data: request);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPostObject(
      String urlExtention, BaseRequest request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options,
          data: request);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalPatch(
      String urlExtention, Map<dynamic, dynamic> request) async {
    try {
      Response response = await dio
          .patch(ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
              options: options, data: request)
          .catchError((onError) {});
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<MakeRateResponse> makeProductRate(MakeRateRequest request) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.MakeRate));

      formData = new FormData.fromMap(request.toJson());
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.MakeRate),
          options: options,
          data: formData);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        MakeRateResponse makeRateResponse =
            MakeRateResponse.fromJson(response.data);

        return makeRateResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        MakeRateResponse makeRateResponse =
            MakeRateResponse.fromJson(response.data);

        print(makeRateResponse.toString());
        return makeRateResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalGet2(String urlExtension) async {
    try {
      Response response = await dio.get(
        ApiRoutesUpdate().getLink2(ApiRoutes.generalGet(urlExtension)),
        options: options,
      );

      print(response);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> generalGet3(String urlExtension) async {
    try {
      Response response = await dio.get(
        ApiRoutesUpdate().getLink3(ApiRoutes.generalGet(urlExtension)),
        options: options,
      );

      print(response);
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
