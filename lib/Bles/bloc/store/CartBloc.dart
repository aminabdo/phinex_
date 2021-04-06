import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';
import 'package:phinex/Bles/Repository/CartRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import 'WishListBloc.dart';

class CartBloc extends BaseBloc {
  final CartRepository _repository = CartRepository();

  BehaviorSubject<Response> _addToCart = BehaviorSubject<Response>();
  BehaviorSubject<Response> _updateCart = BehaviorSubject<Response>();
  BehaviorSubject<Response> _delete_item = BehaviorSubject<Response>();
  BehaviorSubject<CartUserResponse> _getUserCart = BehaviorSubject<CartUserResponse>();
  BehaviorSubject<int> _cartCounter = BehaviorSubject<int>();

  clear() {
    _addToCart = BehaviorSubject<Response>();
    _updateCart = BehaviorSubject<Response>();
    _delete_item = BehaviorSubject<Response>();
    _getUserCart = BehaviorSubject<CartUserResponse>();
    _cartCounter = BehaviorSubject<int>();
  }

  addToMyCart(AddToCartRequest request) async {
    _cartCounter.value++;
    wishlistBloc.wishlistCounter.value = wishlistBloc.wishlistCounter.value;
    Response response = await _repository.addToCart(request);

    _addToCart.value = response;

    return response;
  }

  getUserCart(int userID) async {
    loading.value = true;

    CartUserResponse response = await _repository.getcart(userID);

    _cartCounter.value = response.data.length;
    wishlistBloc.wishlistCounter.value = wishlistBloc.wishlistCounter.value;

    print("getUserCart response --->> " + response.toJson().toString());
    _getUserCart.value = response;

    loading.value = false;
  }

  deleteCartItem(CartUserBean cartUserBean, {dynamic userId, dynamic productId}) async {
    _cartCounter.value--;
    wishlistBloc.wishlistCounter.value = wishlistBloc.wishlistCounter.value;
    print("deleteCartItem  -- user ID --->>" + userId.toString() ?? cartUserBean.userId.toString());
    print("deleteCartItem  -- productId --->>" + productId.toString() ?? cartUserBean.productId.toString());
    Response response = await _repository.deleteCartItem(userId ?? cartUserBean.userId, productId ?? cartUserBean.productId);

    print(response);

    _delete_item.value = response;
    print("cartcounter --->>" + _cartCounter.value.toString());
  }

  updateCartItem(int userID, int productID, int qty) async {
    Response response =
        await _repository.updateCartItem(userID, productID, qty);
    print("response updateCartItem --->> " + response.statusCode.toString());

    _updateCart.value = response;

    return response;
    //_updateCartItem(cartUserBean);
  }

  void _updateCartItem(CartUserBean product) {
    int index = _getUserCart.value.data
        .indexWhere((element) => product.id == element.id);
    _getUserCart.value.data[index] = product;
  }

  void _removeCartItem(CartUserBean product) {
    _getUserCart.value.data.remove(product);
    _getUserCart.value = _getUserCart.value;
  }

  dispose() {
    _addToCart.close();
    _updateCart.close();
    _getUserCart.close();
    _cartCounter.close();
  }

  BehaviorSubject<Response> get addToCart => _addToCart;

  BehaviorSubject<Response> get updateCart => _updateCart;

  BehaviorSubject<CartUserResponse> get userCart => _getUserCart;

  BehaviorSubject<int> get cartCounter => _cartCounter;
}

// amin
final cartBloc = CartBloc();
