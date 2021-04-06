
import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellByCatReposnse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSingleResponse.dart';
import 'package:phinex/Bles/api_provider/buy_sell/BuySellApiProvider.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class BuySellRepository {
  BuySellApiProvider _buySellApiProvider = BuySellApiProvider();

  Future<BuySellSearchResponse> search(String search) {
    return _buySellApiProvider.search(search);
  }

  Future<BuySellByCatReposnse> getBuySellByCatID(SearchRequest request) {
    return _buySellApiProvider.getBuySellByCatID(request);
  }

  Future<BuySellSingleResponse> getSingleBuySell(int id) {
    return _buySellApiProvider.getSingleBuySell(id);
  }

  Future<BuySellLandingResponse> getBuySell() {
    return _buySellApiProvider.getBuySell();
  }
  Future<Response> createBuySell(BaseRequest request) {
    return _buySellApiProvider.createBuySell(request);
  }
}
