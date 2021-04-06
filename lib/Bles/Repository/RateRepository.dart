
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';
import 'package:phinex/Bles/api_provider/rate/RateApiProvider.dart';

class RateRepository {
  RateApiProvider _apiProvider = RateApiProvider();

  Future<MakeRateResponse> makeRate(MakeRateRequest request) {
    return _apiProvider.makeProductRate(request);
  }
}
