import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class RateApiProvider extends BaseApiProvider {

  Future<MakeRateResponse> makeProductRate(MakeRateRequest request) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.MakeRate));

      formData = new FormData.fromMap(request.toJson());
      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.MakeRate),
          options: options,
          data: formData);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        MakeRateResponse makeRateResponse =
            MakeRateResponse.fromJson(response.data);

        return makeRateResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);
        MakeRateResponse makeRateResponse =
            MakeRateResponse.fromJson(response.data);

        print(makeRateResponse.toString());
        return makeRateResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
}
