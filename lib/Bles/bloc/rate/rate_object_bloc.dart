
import 'package:dio/dio.dart';
import 'package:phinex/Bles/ApiRoutes.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class SeeMoreBloc extends BaseBloc {
  Future<void> getMoreReviews(String objectName, String objectId, BaseRequestSkipTake request) async {
    Response response = await repository.get(ApiRoutes.getMoreReviews(objectName, objectId, request));
    if(objectName == 'technician') {
      professionsBloc.single.value = professionsBloc.single.value;
    }
  }
}

final seeMoreBloc = SeeMoreBloc();