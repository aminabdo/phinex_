import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/index/IndexLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSearchResponse.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSingleResponse.dart';
import 'package:phinex/Bles/Model/responses/index/indexByCatResponse.dart';
import 'package:phinex/Bles/api_provider/index/IndexApiProvider.dart';

class IndexRepository {
  IndexApiProvider _apiProvider = IndexApiProvider();

  Future<IndexLandingResponse> getIndexLanding() {
    return _apiProvider.getIndexLanding();
  }

  Future<IndexByCatResponse> getIndexByCat(BaseRequestSkipTake request) {
    return _apiProvider.getIndexByCat(request);
  }

  Future<IndexSingleResponse> getIndexSingle(int id) {
    return _apiProvider.getIndexSingle(id);
  }

  Future<IndexSearchResponse> getIndexSearch(String search) {
    return _apiProvider.getIndexSearch(search);
  }
}
