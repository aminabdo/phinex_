import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByCatResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsSearchResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class ProfessionsApiProvider extends BaseApiProvider {

  Future<ProfessionsLandingResponse> getProfessionsLanding() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.professionsLanding),
          options: options);

      return ProfessionsLandingResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ProfessionsByCatResponse> getProfessionsByCat(BaseRequestSkipTake request) async {
    try {
      print("ProfessionsSearchResponse request --->"+ApiRoutesUpdate().getLink(ApiRoutes.professionsByCat(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.professionsByCat(request)),
          options: options);

      print("ProfessionsSearchResponse ---> Response");
      print(ProfessionsByCatResponse.fromMap(response.data).toJson());
      return ProfessionsByCatResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ProfessionsByUserResponse> getProfessionsByUser(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.ProfessionsByUser(id)),
          options: options);

      return ProfessionsByUserResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<ProfessionsSearchResponse> getProfessionsSearch(String search) async {
    try {
      formData = FormData.fromMap({"search":search});
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.professionsSearch),
          options: options ,data: formData);

      return ProfessionsSearchResponse.fromMap(response.data);
      
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
