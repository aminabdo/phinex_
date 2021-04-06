import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/responses/SearchAllResponse.dart';
import 'package:phinex/Bles/Model/responses/SearchLiteResponse.dart';
import 'package:phinex/Bles/Model/responses/general/GeneralModelGovResponse.dart';
import 'package:phinex/Bles/Repository/general/CountriesResponse.dart';
import 'package:phinex/Bles/Repository/general/GeneralRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';


class GeneralBloc extends BaseBloc {
  final GeneralRepository _repository = GeneralRepository();

  // ignore: close_sinks
  BehaviorSubject<List<Governorates>> _governorates = BehaviorSubject<List<Governorates>>();

  // ignore: close_sinks
  BehaviorSubject<List<Models>> _models = BehaviorSubject<List<Models>>();
  // ignore: close_sinks

  BehaviorSubject<GeneralModelGovResponse> _generalGovModel = BehaviorSubject<GeneralModelGovResponse>();
  // ignore: close_sinks

  BehaviorSubject<CountriesResponse> _countries = BehaviorSubject<CountriesResponse>();

  // ignore: close_sinks
  BehaviorSubject<SearchAllResponse> _search = BehaviorSubject<SearchAllResponse>();

  // ignore: close_sinks
  BehaviorSubject<SearchLiteResponse> _searchLite =BehaviorSubject<SearchLiteResponse>();

  getModelGov() async {
    loading.value = true;
    GeneralModelGovResponse response = GeneralModelGovResponse.fromMap((await _repository.get(ApiRoutes.carRentalDetails)).data);
    _generalGovModel.value = response;
    _governorates.value = response.data.governorates;
    _models.value = response.data.models;
    loading.value = false;
  }

  getCountries() async {
    loading.value = true;
    CountriesResponse response = CountriesResponse.fromMap((await _repository.get(ApiRoutes.countries)).data);
    _countries.value = response;
    loading.value = false;
  }

  Future<void> searchGet (String search) async {
    loading.value = true;
    loading.value = loading.value;
    SearchAllResponse response = SearchAllResponse.fromJson((await repository.post(ApiRoutes.search, {"search":search})).data);
    _search.value = response;
    loading.value = false;
    loading.value = loading.value;
    _search.value = _search.value;
  }

  BehaviorSubject<List<Governorates>> get governorates => _governorates;

  BehaviorSubject<List<Models>> get models => _models;

  BehaviorSubject<GeneralModelGovResponse> get generalGovModel =>_generalGovModel;

  BehaviorSubject<SearchAllResponse> get search =>_search;

  BehaviorSubject<SearchLiteResponse> get searchLite =>_searchLite;

  BehaviorSubject<CountriesResponse> get countries =>_countries;
}

final generalBloc = GeneralBloc();
