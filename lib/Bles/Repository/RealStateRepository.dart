import 'package:phinex/Bles/Model/requests/real_state/RealStateFilterRequest.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateFilterResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/real_state/RealStateSingleResponse.dart';
import 'package:phinex/Bles/api_provider/real_state/RealStateApiProvider.dart';

class RealStateRepository {
  RealStateApiProvider _apiProvider = RealStateApiProvider();

  Future<RealStateFilterResponse> getRealStateFilter(
      RealStateFilterRequest request) {
    return _apiProvider.getRealStateFilter(request);
  }

  Future<RealStateSearchResponse> getRealStateSearch(String search) {
    return _apiProvider.getRealStateSearch(search);
  }

  Future<RealStateSingleResponse> getRealStateSingle(int id) {
    return _apiProvider.getRealStateSingle(id);
  }
}
