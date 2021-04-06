import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/real_state/RealStateFilterRequest.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSingleResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class RealStateApiProvider extends BaseApiProvider {

  Future<RealStateFilterResponse> getRealStateFilter(RealStateFilterRequest request) async {
    try {

      Response response = await dio.post(ApiRoutesUpdate().getLink(ApiRoutes.realStateFilter(request)), options: options, data: request.tojson());

      print("RealStateApiProvider -->  getFilter --->"+response.data.toString());

      print("before return");
      return RealStateFilterResponse.fromMap(response.data);
    } catch (error, stacktrace) {

      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
  
  Future<RealStateSearchResponse> getRealStateSearch(String search) async {
    try {

      formData = FormData.fromMap({"search":search});
      Response response = await dio.post(ApiRoutesUpdate().getLink(ApiRoutes.realStateSearch), options: options , data: formData);

      print("getIndexByCat ---> Response");
      print(RealStateSearchResponse.fromMap(response.data).toJson());
      return RealStateSearchResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<RealStateSingleResponse> getRealStateSingle(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.realStateSingle(id)),
          options: options);

      return RealStateSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}