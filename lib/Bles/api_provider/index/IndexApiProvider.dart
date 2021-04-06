import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/index/IndexLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/index/indexByCatResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class IndexApiProvider extends BaseApiProvider {
  Future<IndexLandingResponse> getIndexLanding() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.indexLanding),
          options: options);

      return IndexLandingResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<IndexByCatResponse> getIndexByCat(BaseRequestSkipTake request) async {
    try {
      print("getIndexByCat request --->" +
          ApiRoutesUpdate().getLink(ApiRoutes.indexByCatID(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.indexByCatID(request)),
          options: options);

      print("getIndexByCat ---> Response");
      print(IndexByCatResponse.fromMap(response.data).toJson());
      return IndexByCatResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<IndexSingleResponse> getIndexSingle(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.indexSingle(id)),
          options: options);

      return IndexSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<IndexSearchResponse> getIndexSearch(String search) async {
    try {
      formData = FormData.fromMap({"search": search});
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.indexSearch),
          options: options,
          data: formData);

      return IndexSearchResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
