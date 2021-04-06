import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/order/CheckoutRequest.dart';
import 'package:phinex/Bles/Model/responses/order/CheckoutResponse.dart';
import 'package:phinex/Bles/Model/responses/order/OrdersResponse.dart';
import 'package:phinex/Bles/Model/responses/order/SinleOrderRespose.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class OrderApiProvider extends BaseApiProvider {


  Future<CheckoutResponse> checkoutOrder(CheckoutRequest request) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.checkoutOrder()));

      //formData = request.toJson() as FormData;//new FormData.fromMap(request.toJson());

      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.checkoutOrder()),
          options: options,
          data: request);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("success");

        return CheckoutResponse.fromMap(response.data);
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return CheckoutResponse.fromMap(response.data);
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<OrdersResponse> getOrders(int userID) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.getOrders(userID)));

      //formData = request.toJson() as FormData;//new FormData.fromMap(request.toJson());

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getOrders(userID)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("success");

        return OrdersResponse.fromMap(response.data);
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return OrdersResponse.fromMap(response.data);
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
  Future<SinleOrderRespose> getSingleOrder(int orderID) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.getSingleOrder(orderID)));

      //formData = request.toJson() as FormData;//new FormData.fromMap(request.toJson());

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getSingleOrder(orderID)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("success");

        return SinleOrderRespose.fromMap(response.data);
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return SinleOrderRespose.fromMap(response.data);
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


}
