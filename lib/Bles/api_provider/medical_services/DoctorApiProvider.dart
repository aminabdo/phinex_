import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/medical/BookNowRequest.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBookNowResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorBySpecialityResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorLanding.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorReviewsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/doctor/DoctorSingleResponse.dart';
import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class DoctorApiProvider extends BaseApiProvider {

  Future<DoctorLanding> getDoctorLanding() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.doctorLanding),
          options: options);

      return DoctorLanding.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<DoctorBySpecialityResponse> getDoctorByCat(BaseRequestSkipTake request) async {
    try {
      print("ProfessionsSearchResponse request --->"+ApiRoutesUpdate().getLink(ApiRoutes.doctorBySpecialityID(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.doctorBySpecialityID(request)),
          options: options);

      print("ProfessionsSearchResponse ---> Response");
      print(DoctorBySpecialityResponse.fromMap(response.data).toJson());
      return DoctorBySpecialityResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<DoctorSingleResponse> getDoctorByUser(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.doctorSingle(id)),
          options: options);

      return DoctorSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<DoctorBookNowResponse> bookNow(BookNowRequest request) async {
    try {
      formData = FormData.fromMap({"search":request.toJson()});
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.doctorBookNow),
          options: options ,data: request.toJson());

      return DoctorBookNowResponse.fromMap(response.data);

    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<DoctorReviewsResponse> getDoctorReviews(BaseRequestSkipTake request) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.doctorReviews(request)),
          options: options);

      print(DoctorReviewsResponse.fromMap(response.data).toJson());
      return DoctorReviewsResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}