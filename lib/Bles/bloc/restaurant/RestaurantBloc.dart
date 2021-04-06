import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/requests/restaurant/RestaurantCreateRequest.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantsByCat.dart';
import 'package:phinex/Bles/Repository/RestaurantRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class RestaurantBloc extends BaseBloc {
  final RestaurantRepository _repository = RestaurantRepository();

  BehaviorSubject<RestaurantLandinResponse> _landing =
      BehaviorSubject<RestaurantLandinResponse>();
  BehaviorSubject<RestaurantsByCatResponse> _redtaurantByCat =
      BehaviorSubject<RestaurantsByCatResponse>();
  BehaviorSubject<RestaurantSearchResponse> _search =
      BehaviorSubject<RestaurantSearchResponse>();
  BehaviorSubject<RestaurantSingleResponse> _single =
      BehaviorSubject<RestaurantSingleResponse>();

  getLanding() async {
    loading.value = true;

    RestaurantLandinResponse response =
        await _repository.getRestaurantLanding();
    _landing.value = response;
    loading.value = false;
  }

  getByCat(SearchRequest request) async {
    loading.value = true;

    RestaurantsByCatResponse response;
    if (request.search == "" || request.search.isEmpty) {
      getLanding();
    } else {
      response = await _repository.getRestaurantByCat(request);
      if (response.data == null || response.data.isEmpty) {
        _landing.value = _landing.value;
      } else {
        _landing.value.data.restaurants = response.data;
        _landing.value = _landing.value;
      }
    }

    loading.value = false;
  }

  getSearch(String search) async {
    loading.value = true;

    RestaurantSearchResponse response =
        await _repository.getRestaurantSearch(search);

    _landing.value.data.restaurants = response.data;
    _landing.value = _landing.value;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    RestaurantSingleResponse response =
        await _repository.getRestaurantSingle(id);

    _single.value = response;
    loading.value = false;
  }

  getMeals(BaseRequestSkipTake request) async {
    loading.value = true;

    RestaurantSingleResponse response =
        await _repository.getRestaurantMeals(request);

    _single.value = response;
    loading.value = false;
  }

  createRestaurant(RestaurantCreateRequest request) async {
    loading.value = true;
    create.value =
        await repository.post(ApiRoutes.restaurantCreate, request.toJson());
    loading.value = false;
  }

  dispose() {
    super.dispose();
    _landing.close();
    _redtaurantByCat.close();
    _single.close();
    _search.close();
  }

  clear() {
    try {
      super.clear();
      _landing.value.data.restaurants = [];
      _redtaurantByCat = BehaviorSubject<RestaurantsByCatResponse>();
      _single = BehaviorSubject<RestaurantSingleResponse>();
      _search = BehaviorSubject<RestaurantSearchResponse>();
    } catch (ex) {}
  }

  BehaviorSubject<RestaurantLandinResponse> get landing => _landing;

  BehaviorSubject<RestaurantSingleResponse> get single => _single;

  BehaviorSubject<Response> get createRest => create;
}

// amin
final restaurantBloc = RestaurantBloc();
