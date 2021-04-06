import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:phinex/Bles/Model/requests/cart/AddToCartRequest.dart';
import 'package:phinex/Bles/Model/responses/cart/CartUserResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class CartApiProvider extends BaseApiProvider {

  Future<Response> addProductToCart(AddToCartRequest request) async {
    try {
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.addToCart));

      print("cart --- >>> " + request.cartProducts.first.toJson().toString());
      //formData = request.toJson() as FormData;//new FormData.fromMap(request.toJson());

      Response response = await dio.post(
          ApiRoutesUpdate().getLink(ApiRoutes.addToCart),
          options: options,
          data: request);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        print("success");
        return response;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return response;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<CartUserResponse> getUserCart(int userID) async {
    try {
      print("response --------...... ---> " + userID.toString());
      print("response --------...... ---> " +
          ApiRoutesUpdate().getLink(ApiRoutes.getUserCart(userID)));

      Response response = await dio.get(
          ApiRoutesUpdate().getLink(ApiRoutes.getUserCart(userID)),
          options: options);

      if (response.statusCode >= 200 && response.statusCode <= 200) {
        debugPrint(
          "test --> " + response.data.toString(),
        );
        CartUserResponse cartUserResponse =
            CartUserResponse.fromMap(response.data);
        print("success " + cartUserResponse.toJson().toString());
        return cartUserResponse;
      } else {
        print("else ----->" + response.statusCode.toString());
        print("else ----->" + response.statusMessage);

        return CartUserResponse.fromMap(response.data);
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> deleteCartItem(int userID, int productID) async {
    try {
      print("api getway --------...... ---> " + ApiRoutesUpdate().getLink(ApiRoutes.deleteCartItem(userID, productID)));
      Response response = await dio.delete(ApiRoutesUpdate().getLink(ApiRoutes.deleteCartItem(userID, productID)), options: options);

      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<Response> updateCartItem(int userID , int productID, int qty) async {
    try {
      var params = {"quantity": qty , "user_id": userID,"product_id": productID};
      print("api link " +ApiRoutesUpdate().getLink(ApiRoutes.updateCartItem(userID,productID)));

      Response response = await dio.put(
          ApiRoutesUpdate().getLink(ApiRoutes.updateCartItem(userID,productID)),
          options: options,
          data: json.encode(params));

      print("api response message---> " + response.data.toString());
      return response;
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }
  
}



