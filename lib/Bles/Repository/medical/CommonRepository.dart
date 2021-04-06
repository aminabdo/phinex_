import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/ClinicLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonPaginResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/common/CommonSingleResponse.dart';
import 'package:phinex/Bles/api_provider/medical_services/CommonApiProvider.dart';

class MedicalCommonRepository {
  CommonApiProvider _apiProvider = CommonApiProvider();

  Future<CommonPaginResponse> getCommonLanding(String objName) {

    return _apiProvider.getCommonLanding(objName);
  }
  Future<CommonPaginResponse> getCommonPagin(BaseRequestSkipTake request ,String objName) {

    return _apiProvider.getCommonPagin(request, objName);
  }
  Future<CommonSingleResponse> getCommonSingle(int id,String objName) {

    return _apiProvider.getCommonSingle(id,objName);
  }
  Future<ClinicLandingResponse> getClinicLanding(String objName) {

    return _apiProvider.getClinicLanding(objName);
  }

  Future<Response> bookNow(BookNowRequest request) {

    return _apiProvider.bookNow(request);
  }
}
