import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBookNowResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBySpecialityResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorLanding.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorReviewsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorSingleResponse.dart';
import 'package:phinex/Bles/api_provider/medical_services/DoctorApiProvider.dart';
import 'package:phinex/utils/base/BaseRepository.dart';

class DoctorRepository extends BaseRepository {
  DoctorApiProvider _apiProvider = DoctorApiProvider();

  Future<DoctorLanding> getDoctorLanding() {
    return _apiProvider.getDoctorLanding();
  }

  Future<DoctorBySpecialityResponse> getDoctorByCat(
      BaseRequestSkipTake request) {
    return _apiProvider.getDoctorByCat(request);
  }

  Future<DoctorSingleResponse> getDoctorSingle(int id) {
    return _apiProvider.getDoctorByUser(id);
  }

  Future<DoctorBookNowResponse> bookNow(BookNowRequest request) {
    return _apiProvider.bookNow(request);
  }

  Future<DoctorReviewsResponse> getDoctorReviews(BaseRequestSkipTake request) {
    return _apiProvider.getDoctorReviews(request);
  }
}
