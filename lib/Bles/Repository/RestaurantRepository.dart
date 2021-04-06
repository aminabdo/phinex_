

import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantsByCat.dart';
import 'package:phinex/Bles/api_provider/restaurant/RestaurantApiProvider.dart';

class RestaurantRepository {
  RestaurantApiProvider _apiProvider = RestaurantApiProvider();


  Future<RestaurantLandinResponse> getRestaurantLanding() {

    return _apiProvider.getRestaurantLanding();
  }

  Future<RestaurantsByCatResponse> getRestaurantByCat(SearchRequest request) {
    return _apiProvider.getRestaurantByCat(request);
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(String search) {
    return _apiProvider.getRestaurantSearch(search);
  }

  Future<RestaurantSingleResponse> getRestaurantSingle(int id) {
    return _apiProvider.getRestaurantSingle(id);
  }

  Future<RestaurantSingleResponse> getRestaurantMeals(BaseRequestSkipTake request) {
    return _apiProvider.getRestaurantMeals(request);
  }

}