import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyProductsResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacyReviewResponse.dart';
import 'package:phinex/Bles/Model/responses/medical_service/pharmacy/PharmacySingleResponse.dart';
import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class PharmacyApiProvider extends BaseApiProvider {

  Future<PharmacyLandingResponse> getPharmacyLanding(BaseRequestSkipTake request) async {
    try {
      print("PharmacyLandingResponse request --->"+request.toString());
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.pharmacies(request)),
          options: options);

      print("PharmacyLandingResponse ---> Response");
      print(PharmacyLandingResponse.fromMap(response.data).toJson());
      return PharmacyLandingResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<PharmacyLandingResponse> getPharmacies(BaseRequestSkipTake request) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.pharmacies(request)),
          options: options);

      print("PharmacyLandingResponse ---> Response");
      print(PharmacyLandingResponse.fromMap(response.data).toJson());
      return PharmacyLandingResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<PharmacySingleResponse> getPharmacySingle(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.pharamcySingle(id)),
          options: options);

      return PharmacySingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<PharmacyReviewsResponse> getPharmacyReviews(BaseRequestSkipTake request) async {
    try {
      print("PharmacyLandingResponse request --->"+ApiRoutesUpdate().getLink(ApiRoutes.pharmacyReviews(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.pharmacyReviews(request)),
          options: options);

      print("PharmacyReviewsResponse ---> Response");
      print(PharmacyReviewsResponse.fromMap(response.data).toJson());
      return PharmacyReviewsResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<PharmacyProductsResponse> getPharmacyProducts(BaseRequestSkipTake request) async {
    try {
      print("PharmacyLandingResponse request --->"+ApiRoutesUpdate().getLink(ApiRoutes.pharmacyProducts(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.pharmacyProducts(request)),
          options: options);

      print("PharmacyProductsResponse ---> Response");
      print(PharmacyProductsResponse.fromMap(response.data).toJson());
      return PharmacyProductsResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

}