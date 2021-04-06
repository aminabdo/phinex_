import 'package:phinex/Bles/Model/requests/order/CheckoutRequest.dart';
import 'package:phinex/Bles/Model/responses/order/CheckoutResponse.dart';
import 'package:phinex/Bles/Model/responses/order/OrdersResponse.dart';
import 'package:phinex/Bles/Model/responses/order/SinleOrderRespose.dart';
import 'package:phinex/Bles/api_provider/order/OrderApirovider.dart';

class OrderRepository {
  OrderApiProvider _orderApiProvider = OrderApiProvider();

  Future<CheckoutResponse> checkoutOrder(CheckoutRequest request) {
    return _orderApiProvider.checkoutOrder(request);
  }

  Future<SinleOrderRespose> getSingleOrder(int orderID) {
    return _orderApiProvider.getSingleOrder(orderID);
  }

  Future<OrdersResponse> getOrders(int userID) {
    return _orderApiProvider.getOrders(userID);
  }
}
