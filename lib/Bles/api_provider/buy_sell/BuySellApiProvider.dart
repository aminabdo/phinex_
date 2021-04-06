import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellByCatReposnse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSingleResponse.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class BuySellApiProvider extends BaseApiProvider {
  Future<BuySellSearchResponse> search(String search) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.buySellSearch));

      formData = new FormData.fromMap({"search": search});
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.buySellSearch),
          options: options,
          data: formData);

      return BuySellSearchResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<BuySellLandingResponse> getBuySell() async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.buySellLanding),
          options: options);

      BuySellLandingResponse.fromMap(response.data)
          .data
          .categoriesItems
          .forEach((element) {
        print("elemenet >>> --- >>>> {$element} \n ");
      });
      return BuySellLandingResponse.fromMap(response.data);
      // return BaseResponse.fromMap(response.data);

    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<BuySellSingleResponse> getSingleBuySell(int id) async {
    try {
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getBuySellSingle(id)),
          options: options);

      return BuySellSingleResponse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<BuySellByCatReposnse> getBuySellByCatID(SearchRequest request) async {
    try {
      print("filter buy & sell end point  ->>  " +
          ApiRoutesUpdate().getLink(ApiRoutes.getBuySellByCat(request)));
      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getBuySellByCat(request)),
          options: options);

      return BuySellByCatReposnse.fromMap(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future updateCartItem(int userID, int productID, int qty) {}

  Future<Response> createBuySell(BaseRequest request) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.buySellCreate));

      // for (File file in request.gallery) {
      //   formData.files.addAll([
      //     MapEntry("gallery[]", await MultipartFile.fromFile(file.path)),
      //   ]);
      // }

      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.buySellCreate),
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
