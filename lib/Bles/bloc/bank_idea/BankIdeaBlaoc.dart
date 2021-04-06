
import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/bank_idea/BankIdeaRequest.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class BankIdeaBloc extends BaseBloc {
      
  Future<Response> makeIdea(BankIdeaRequest request) async {
    return (await repository.post(ApiRoutes.bankIdeas(), request.toJson()));
  }
}

final bankIdeaBloc = BankIdeaBloc();