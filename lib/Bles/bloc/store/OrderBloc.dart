import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/order/CheckoutRequest.dart';
import 'package:phinex/Bles/Model/responses/order/CheckoutResponse.dart';
import 'package:phinex/Bles/Model/responses/order/OrdersResponse.dart';
import 'package:phinex/Bles/Model/responses/order/SinleOrderRespose.dart';
import 'package:phinex/Bles/Repository/OrderRepositoy.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class OrderBloc extends BaseBloc {
  final OrderRepository _repository = OrderRepository();

  BehaviorSubject<CheckoutResponse> _checkout =
      BehaviorSubject<CheckoutResponse>();
  BehaviorSubject<SinleOrderRespose> _singleOrder =
      BehaviorSubject<SinleOrderRespose>();
  BehaviorSubject<OrdersResponse> _myOrders = BehaviorSubject<OrdersResponse>();

  Future<CheckoutResponse> checkoutOrder(CheckoutRequest request) async {

    print(request.toJson());
    CheckoutResponse response = await _repository.checkoutOrder(request);
    _checkout.value = response;
    return response;
  }

  getSingleOrder(int orderID) async {
    loading.value = true;

    SinleOrderRespose response = await _repository.getSingleOrder(orderID);
    _singleOrder.value = response;
    loading.value = false;

  }

  getMyOrders(int userID) async {
    loading.value = true;

    OrdersResponse response = await _repository.getOrders(userID);

    _myOrders.value = response;

    loading.value = true;

  }

  dispose() {
    _checkout.close();
    _singleOrder.close();
    _myOrders.close();
  }

  clear() {
    _checkout = BehaviorSubject<CheckoutResponse>();
    _singleOrder = BehaviorSubject<SinleOrderRespose>();
    _myOrders = BehaviorSubject<OrdersResponse>();
  }

  BehaviorSubject<CheckoutResponse> get checkout => _checkout;

  BehaviorSubject<SinleOrderRespose> get singleOrder => _singleOrder;

  BehaviorSubject<OrdersResponse> get myOrders => _myOrders;
}

// amin
final orderBloc = OrderBloc();
