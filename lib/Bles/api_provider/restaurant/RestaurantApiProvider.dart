import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantLandinResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantsByCat.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class RestaurantApiProvider extends BaseApiProvider {
  Future<RestaurantLandinResponse> getRestaurantLanding() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.restaurantLanding),
          options: options);

      return RestaurantLandinResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<RestaurantsByCatResponse> getRestaurantByCat(
      SearchRequest request) async {
    Response response = null;
    try {
      print("" + request.toString());
      formData = FormData.fromMap({"categories": request.search});
      // options.contentType ="application/x-www-form-urlencoded";
      response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.restaurantByCat(request)),
          options: options,
          data: formData);

      return RestaurantsByCatResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");

      return null;
    }
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(String search) async {
    try {
      formData = FormData.fromMap({"search": search});
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.restaurantSearch),
          options: options,
          data: formData);

      print("getIndexByCat ---> Response");
      return RestaurantSearchResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<RestaurantSingleResponse> getRestaurantSingle(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.restaurantSingle(id)),
          options: options);

      return RestaurantSingleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<RestaurantSingleResponse> getRestaurantMeals(
      BaseRequestSkipTake request) async {
    try {
      print(
          'RestaurantSingleResponse filter request >>>>> ${ApiRoutesUpdate().getLink(ApiRoutes.restaurantMeals(request))}');

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.restaurantMeals(request)),
          options: options);

      print("RestaurantSingleResponse -->  getFilter --->" +
          response.data.toString());

      print("before return");
      return RestaurantSingleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
