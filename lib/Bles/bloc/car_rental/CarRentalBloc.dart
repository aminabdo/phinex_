import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalFilterationRequest.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalSingleResponse.dart';
import 'package:phinex/Bles/Repository/CarRentalRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class CarRentalBloc extends BaseBloc {
  final CarRentalRepository _repository = CarRentalRepository();

  BehaviorSubject<CarRentalFilterResponse> _filter = BehaviorSubject<CarRentalFilterResponse>();
  BehaviorSubject<CarRentalSingleResponse> _single = BehaviorSubject<CarRentalSingleResponse>();
  BehaviorSubject<CarRentalSearchResponse> _search = BehaviorSubject<CarRentalSearchResponse>();
  BehaviorSubject<Response> _create = BehaviorSubject<Response>();

  getSearch(SearchRequest request) async {
    loading.value = true;
    CarRentalSearchResponse response =
        await _repository.getCarRentalSearch(request);

    _filter.value.data.cars = response.data;
    _filter.value = _filter.value;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    CarRentalSingleResponse response = await _repository.getCarRentalSingle(id);

    _single.value = response;

    loading.value = false;
  }

  Future<void> getFilter(CarRentalFilterationRequest request) async {
    loading.value = true;

    print('================ => ${request.tojson()}');

    CarRentalFilterResponse response = await _repository.getCarRentalFilter(request);

    print("bloc -->  getFilter --->" + response.data.toString());
    _filter.value = response;

    loading.value = false;
    _filter.value = _filter.value;
  }

  Future<Response> createCar(BaseRequest request) async {
    loading.value = true;

    Response response = await _repository.createCarRental(request);
    _create.value = response;

    loading.value = false;
    return response;
  }

  dispose() {
    _filter.close();
    _single.close();
    _search.close();
    _create.close();
  }

  clear() {
    _filter = BehaviorSubject<CarRentalFilterResponse>();
    _single = BehaviorSubject<CarRentalSingleResponse>();
    _search = BehaviorSubject<CarRentalSearchResponse>();
    _create = BehaviorSubject<Response>();
  }

  BehaviorSubject<CarRentalFilterResponse> get filter => _filter;

  BehaviorSubject<CarRentalSingleResponse> get single => _single;

  BehaviorSubject<Response> get create => _create;
}

// amin
final carRentalBloc = CarRentalBloc();
