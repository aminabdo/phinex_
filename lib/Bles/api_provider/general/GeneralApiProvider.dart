import 'package:dio/dio.dart';
import 'package:phinex/utils/base/BasePostResponse.dart';
import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class GeneralApiProvider extends BaseApiProvider{


  Future<Response> generalGet(String urlExtention) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.generalGet(urlExtention)),
          options: options);

      return response;

    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
  Future<BasePostResponse> generalPost(String urlExtention,Map<dynamic,dynamic> request) async {
    try {
      BasePostResponse response = await dio.post(
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
}