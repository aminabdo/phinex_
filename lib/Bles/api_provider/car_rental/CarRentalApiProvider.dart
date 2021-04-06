import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalFilterationRequest.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSingleResponse.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class CarRentalApiProvider extends BaseApiProvider {
  Future<CarRentalFilterResponse> getCarRentalFilter(
      CarRentalFilterationRequest request) async {
    try {

      print("CarRentalApiProvider -->  CarRentalFilterationRequest --->" + ApiRoutesUpdate().getLink(ApiRoutes.carRentalFilter(request)));
      Response response;

      response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.carRentalFilter(request)),
          options: options,
          data: request.tojson(),
      );

      print("CarRentalApiProvider -->  getFilter --->" + response.data.toString());

      return CarRentalFilterResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CarRentalSearchResponse> getCarRentalSearch(
      SearchRequest request) async {
    try {
      print("getIndexByCat request --->" +
          ApiRoutesUpdate().getLink(ApiRoutes.carRentalSearch(request)));
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.carRentalSearch(request)),
          options: options,
          data: request.tojson());

      print("getIndexByCat ---> Response");
      print(CarRentalSearchResponse.fromMap(response.data).toJson());
      return CarRentalSearchResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CarRentalSingleResponse> getCarRentalSingle(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.carRentalSingle(id)),
          options: options);

      return CarRentalSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> createCarRental(BaseRequest request) async {
    try {
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.createCarRentalString),
          options: options,
          data: request.toJson());

      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
