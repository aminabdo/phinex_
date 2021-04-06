import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/froms/CreateCalalougeFormRequest.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueByCatResponse.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/catalogue/CatalogueSingleResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class CatalogueBloc extends BaseBloc {

  BehaviorSubject<CatalogueLandingResponse> _landing = BehaviorSubject<CatalogueLandingResponse>();
  BehaviorSubject<CatalogueByCatResponse> _getByCat = BehaviorSubject<CatalogueByCatResponse>();
  BehaviorSubject<CatalogueSingleResponse> _single = BehaviorSubject<CatalogueSingleResponse>();

  getByCatID(BaseRequestSkipTake request) async {
    loading.value = true;

    if(request.skip == 0) {
      CatalogueByCatResponse response = CatalogueByCatResponse.fromMap((await repository.get(ApiRoutes.catalogueByCatID(request))).data);
      _getByCat.value = response;
    } else {
      CatalogueByCatResponse response = CatalogueByCatResponse.fromMap((await repository.get(ApiRoutes.catalogueByCatID(request))).data);
      _getByCat.value.data.addAll(response.data);
    }

    loading.value = false;
    _getByCat.value = _getByCat.value;
  }

  getSingle(int id) async {
    loading.value = true;
    CatalogueSingleResponse response = CatalogueSingleResponse.fromMap((await repository.get(ApiRoutes.catalogueSingle(id))).data);
    _single.value = response;
    loading.value = false;
  }

  getLanding(int parentID) async {
    loading.value = true;
    CatalogueLandingResponse response = CatalogueLandingResponse.fromMap((await repository.get(ApiRoutes.catalogueLanding(parentID))).data);
    _landing.value = response;
    loading.value = false;
  }

  Future<Response> createCatalouge(CreateCatalougeFormRequest request) async {
    response.value = await repository.post(ApiRoutes.createCatalouge, request.toJson());
    return response.value;
  }

  dispose() {
    _landing.close();
    _getByCat.close();
    _single.close();
  }

  clear() {
    _landing = BehaviorSubject<CatalogueLandingResponse>();
    _getByCat = BehaviorSubject<CatalogueByCatResponse>();
    _single = BehaviorSubject<CatalogueSingleResponse>();
  }

  BehaviorSubject<CatalogueLandingResponse> get landing =>  _landing;
  BehaviorSubject<CatalogueByCatResponse> get getByCat => _getByCat;
  BehaviorSubject<CatalogueSingleResponse> get single => _single;

}
// amin
final catalogueBloc = CatalogueBloc();