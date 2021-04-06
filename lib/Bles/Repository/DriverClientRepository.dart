// import 'package:dio/dio.dart';
// import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
// import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';
// import 'package:phinex/Bles/api_provider/cart/CartApiProvider.dart';
// class CartRepository {
//   CartApiProvider _cartApiProvider = CartApiProvider();
//
//   Future<Response> addToCart(AddToCartRequest request) {
//     return _cartApiProvider.addProductToCart(request);
//   }
//
//   Future<CartUserResponse> getcart(int userID) {
//     return _cartApiProvider.getUserCart(userID);
//   }
//
//   Future<Response> deleteCartItem(int userID, int productID) {
//     return _cartApiProvider.deleteCartItem(userID, productID);
//   }
//
//   Future<Response> updateCartItem(int userID , int productID, int qty) {
//     return _cartApiProvider.updateCartItem(userID,productID,qty);
//   }
// }
