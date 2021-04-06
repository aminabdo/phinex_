import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/api_provider/general/GeneralApiProvider.dart';
import 'package:phinex/utils/base/BaseRepository.dart';

class GeneralRepository extends BaseRepository {
  GeneralApiProvider _apiProvider = GeneralApiProvider();

  Future<GeneralModelGovResponse> getModelGov() async {
    print('>>> start requesting');
    Response response = await _apiProvider.generalGet("my/car-rental/details");
    print(response.toString());
    return GeneralModelGovResponse.fromMap(response.data);
  }
  //
  // Future<Response> createPharmacict(PharmacistCreateRequest request) async {
  //   Response response = await _apiProvider.generalPost(ApiRoutes.carRentalDetails ,request.toJson());
  //   return response;
  // }
}
