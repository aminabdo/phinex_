
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyReviewResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacySingleResponse.dart';
import 'package:phinex/Bles/api_provider/medical_services/PharmacyApiProvider.dart';
import 'package:phinex/utils/base/BaseRepository.dart';

class PharmacyRepository extends BaseRepository {
  PharmacyApiProvider _apiProvider = PharmacyApiProvider();

  Future<PharmacyLandingResponse> getPharmacyLanding(BaseRequestSkipTake request) {
    return _apiProvider.getPharmacyLanding(request);
  }

  Future<PharmacyLandingResponse> getPharmacies(BaseRequestSkipTake request) {
    return _apiProvider.getPharmacies(request);
  }
  Future<PharmacySingleResponse> getPharmacySingle(int id) {
    return _apiProvider.getPharmacySingle(id);
  }

  Future<PharmacyReviewsResponse> getPharmacyReviews(BaseRequestSkipTake request) {
    return _apiProvider.getPharmacyReviews(request);
  }

  Future<PharmacyProductsResponse> getPharmacyProducts(BaseRequestSkipTake request) {
    return _apiProvider.getPharmacyProducts(request);
  }
  //
  // Future<Response> createPharmacict(PharmacistReqisterRequest request) async {
  //   Response response = await _apiProvider.cre("my/car-rental/details" ,request);
  //   return response;
  // }
}
