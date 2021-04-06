import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/suggest_service/BankIdeaRequest.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class SuggestServiceBloc extends BaseBloc {
  Future<Response> suggestService(SuggestServiceRequest request) async {
    return (await repository.post(ApiRoutes.suggestService, request.toJson()));
  }
}

final suggestService = SuggestServiceBloc();
