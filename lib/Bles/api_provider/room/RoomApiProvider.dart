import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/responses/room/RoomLandingResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class RoomApiProvider extends BaseApiProvider {
  Future<RoomLandingResponse> getRoomLanding() async {
    try {
      Response response = await dio.get(
        ApiRoutesUpdate().getLink(ApiRoutes.getRoomLanding()),
        options: options,
      );

      return RoomLandingResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
