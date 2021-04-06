import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/real_state/RealStateFilterRequest.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSingleResponse.dart';
import 'package:phinex/Bles/Repository/RealStateRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/base/BaseRequest.dart';

import '../../ApiRoutes.dart';

class RealStateBloc extends BaseBloc {
  final RealStateRepository _repository = RealStateRepository();

  BehaviorSubject<RealStateFilterResponse> _filter =
      BehaviorSubject<RealStateFilterResponse>();
  BehaviorSubject<RealStateSingleResponse> _single =
      BehaviorSubject<RealStateSingleResponse>();
  BehaviorSubject<RealStateSearchResponse> _search =
      BehaviorSubject<RealStateSearchResponse>();

  getSearch(String search) async {
    loading.value = true;

    RealStateSearchResponse response = await _repository.getRealStateSearch(search);

    _filter.value.data.realestates = response.data.results;
    _filter.value = _filter.value;
    loading.value = false;
  }

  getSingle(int id) async {
    loading.value = true;

    RealStateSingleResponse response = await _repository.getRealStateSingle(id);

    _single.value = response;
    loading.value = false;
  }

  getFilter(RealStateFilterRequest request) async {
    loading.value = true;

    print(request.tojson());

    RealStateFilterResponse response = await _repository.getRealStateFilter(request);

    _filter.value = response;
    loading.value = false;
  }

  createRealState(BaseRequest request) async {
    loading.value = true;
    create.value = await repository.post(ApiRoutes.realStateCreate, request.toJson());
    loading.value = false;
  }

  dispose() {
    super.dispose();
    _filter.close();
    _single.close();
    _search.close();
  }

  clear() {
    super.clear();
    _filter = BehaviorSubject<RealStateFilterResponse>();
    _single = BehaviorSubject<RealStateSingleResponse>();
    _search = BehaviorSubject<RealStateSearchResponse>();
  }

  BehaviorSubject<RealStateFilterResponse> get filter => _filter;

  BehaviorSubject<RealStateSingleResponse> get single => _single;
}

// amin
final realStateBloc = RealStateBloc();
