import 'package:phinex/Bles/api_provider/car_rental/CarRentalApiProvider.dart';
import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalFilterationRequest.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSingleResponse.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class CarRentalRepository {
  CarRentalApiProvider _apiProvider = CarRentalApiProvider();

  Future<CarRentalFilterResponse> getCarRentalFilter(CarRentalFilterationRequest request) {

    return _apiProvider.getCarRentalFilter(request);
  }

  Future<CarRentalSearchResponse> getCarRentalSearch(SearchRequest request) {
    return _apiProvider.getCarRentalSearch(request);
  }

  Future<CarRentalSingleResponse> getCarRentalSingle(int id) {
    return _apiProvider.getCarRentalSingle(id);
  }
  Future<Response> createCarRental(BaseRequest request) {
    return _apiProvider.createCarRental(request);
  }
}
