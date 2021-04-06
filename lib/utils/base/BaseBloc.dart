
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';

import '../app_utils.dart';
import 'BaseRepository.dart';

class BaseBloc {
  BehaviorSubject<bool> loading = BehaviorSubject<bool>();
  BehaviorSubject<bool> subLoading = BehaviorSubject<bool>();
  BehaviorSubject<Response> create = BehaviorSubject<Response>();
  BehaviorSubject<Response> get = BehaviorSubject<Response>();
  BehaviorSubject<Response> response = BehaviorSubject<Response>();
  BaseRepository repository = BaseRepository();

  dispose() {
    loading.close();
    create.close();
    get.close();
  }

  clear() {
    loading = BehaviorSubject<bool>();
    create = BehaviorSubject<Response>();
    get = BehaviorSubject<Response>();
  }

  makeRate(MakeRateRequest request) async {
    print(request.toJson());
    MakeRateResponse response = await repository.makeRate(request);
    return response ;
  }

}
