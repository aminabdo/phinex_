import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/index/IndexLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/index/indexByCatResponse.dart';
import 'package:phinex/Bles/Repository/IndexReposiory.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class IndexBloc extends BaseBloc {
  final IndexRepository _repository = IndexRepository();

  BehaviorSubject<IndexLandingResponse> _landing =
      BehaviorSubject<IndexLandingResponse>();
  BehaviorSubject<IndexByCatResponse> _getByCat =
      BehaviorSubject<IndexByCatResponse>();
  BehaviorSubject<IndexSingleResponse> _single =
      BehaviorSubject<IndexSingleResponse>();
  BehaviorSubject<IndexSearchResponse> _search =
      BehaviorSubject<IndexSearchResponse>();

  getSearch(String search) async {
    loading.value = true;
    IndexSearchResponse response = await _repository.getIndexSearch(search);

    _search.value = response;
    loading.value = false;
  }

  getByCatID(BaseRequestSkipTake request) async {
    loading.value = true;

    IndexByCatResponse response = await _repository.getIndexByCat(request);

    _getByCat.value = response;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    IndexSingleResponse response = await _repository.getIndexSingle(id);

    _single.value = response;
    loading.value = false;
  }

  getLanding() async {
    loading.value = true;

    IndexLandingResponse response = await _repository.getIndexLanding();

    _landing.value = response;
    loading.value = false;
  }

  dispose() {
    _landing.close();
    _getByCat.close();
    _single.close();
    _search.close();
  }

  clear() {
    _landing = BehaviorSubject<IndexLandingResponse>();
    _getByCat = BehaviorSubject<IndexByCatResponse>();
    _single = BehaviorSubject<IndexSingleResponse>();
    _search = BehaviorSubject<IndexSearchResponse>();
  }

  BehaviorSubject<IndexLandingResponse> get landing => _landing;

  BehaviorSubject<IndexByCatResponse> get getByCat => _getByCat;

  BehaviorSubject<IndexSingleResponse> get single => _single;

  BehaviorSubject<IndexSearchResponse> get search => _search;
}

// amin
final indexBloc = IndexBloc();
