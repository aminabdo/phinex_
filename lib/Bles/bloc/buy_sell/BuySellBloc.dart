import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellByCatReposnse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/buy_sell/BuySellSingleResponse.dart';
import 'package:phinex/Bles/Repository/BuySellRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

class BuySellBloc extends BaseBloc {
  final BuySellRepository _repository = BuySellRepository();

  BehaviorSubject<BuySellSearchResponse> _search =
      BehaviorSubject<BuySellSearchResponse>();
  BehaviorSubject<Response> _create = BehaviorSubject<Response>();
  BehaviorSubject<BuySellByCatReposnse> _getByCat =
      BehaviorSubject<BuySellByCatReposnse>();
  BehaviorSubject<BuySellSingleResponse> _single =
      BehaviorSubject<BuySellSingleResponse>();
  BehaviorSubject<BuySellLandingResponse> _landing =
      BehaviorSubject<BuySellLandingResponse>();

  getSearch(String search) async {
    loading.value = true;
    BuySellSearchResponse response = await _repository.search(search);
    _search.value = response;
    loading.value = false;
  }

  getByCatID(SearchRequest request) async {
    loading.value = true;
    BuySellByCatReposnse response =
        await _repository.getBuySellByCatID(request);
    _getByCat.value = response;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;
    BuySellSingleResponse response = await _repository.getSingleBuySell(id);
    _single.value = response;
    loading.value = false;
  }

  getLanding() async {
    loading.value = true;
    BuySellLandingResponse response = await _repository.getBuySell();
    _landing.value = response;
    loading.value = false;
  }

  createBuy(BaseRequest request) async {
    Response response = await _repository.createBuySell(request);
    _create.value = response;
    print('=============================');
    print(_create.value.data);
    print('=============================');
  }

  dispose() {
    _search.close();
    _getByCat.close();
    _single.close();
    _landing.close();
    _create.close();
  }

  clear() {
    _search = BehaviorSubject<BuySellSearchResponse>();
    _getByCat = BehaviorSubject<BuySellByCatReposnse>();
    _single = BehaviorSubject<BuySellSingleResponse>();
    _landing = BehaviorSubject<BuySellLandingResponse>();
    _create = BehaviorSubject<Response>();
  }

  BehaviorSubject<BuySellSearchResponse> get search => _search;

  BehaviorSubject<BuySellByCatReposnse> get getByCat => _getByCat;

  BehaviorSubject<BuySellSingleResponse> get single => _single;

  BehaviorSubject<BuySellLandingResponse> get landing => _landing;

  BehaviorSubject<Response> get create => _create;
}

// amin
final buySellBloc = BuySellBloc();
