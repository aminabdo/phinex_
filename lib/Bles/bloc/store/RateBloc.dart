import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';
import 'package:phinex/Bles/Repository/RateRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class RateBloc extends BaseBloc {
  final RateRepository _repository = RateRepository();

  BehaviorSubject<MakeRateResponse> _makeRate =
      BehaviorSubject<MakeRateResponse>();

  Future makeRate(MakeRateRequest request) async {
    print(request.toJson());
    MakeRateResponse response;
     var res = await _repository.makeRate(request);

     response = res;

    _makeRate.value = response;
    print(res.toString());
    return response;
  }

  dispose() {
    _makeRate.close();
  }

  clear() {
     _makeRate = BehaviorSubject<MakeRateResponse>();
  }

  BehaviorSubject<MakeRateResponse> get vendorByID => _makeRate;
}

// amin
final rateBloc = RateBloc();
