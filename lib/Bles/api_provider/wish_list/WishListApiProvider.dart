import 'package:dio/dio.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/Model/responses/wish_list/add_to_wishlist/AddToWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/delete_from_wishlist/DeleteFromWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';

import '../../ApiRoutes.dart';
import '../BaseApiProvider.dart';

class WishListApiProvider extends BaseApiProvider{


  Future<WishListResponse> getWishListUser(int userID) async {
    try {

      print("response --------...... ---> "+ApiRoutesUpdate().getLink(ApiRoutes.getWishListUser(userID)));

      Response response = await dio.get(ApiRoutesUpdate().getLink(ApiRoutes.getWishListUser(userID)),  options: options);

      print("99999 === >>> "+response.toString());
      // print("response 010101 ---> "+response.statusCode.toString());
      // print("response 010101 ---> "+response.statusMessage);
      // print("response 010101 ---> "+response.data.toString());
      // final Map parsed = json.decode(response.data);

      if(response.statusCode >= 200 && response.statusCode <= 200)
      {
        print("if ----->");
        WishListResponse wishListResponse = WishListResponse.fromMap(response.data);

        return wishListResponse;
      }
      else{
        print("else ----->");
        WishListResponse wishListResponse = WishListResponse.fromMap(response.data);


        print(wishListResponse.toJson().toString());
        return wishListResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<AddToWishListResponse> addToWishList(WishListRequest request) async {
    try {

      formData = new FormData.fromMap(request.toJson());
      print("response --------...... ---> "+ApiRoutesUpdate().getLink(ApiRoutes.addToWishListUser));

      Response response = await dio.post(ApiRoutesUpdate().getLink(ApiRoutes.addToWishListUser), data: formData , options: options);

      print("99999 === >>> "+request.toJson().toString());
      // print("response 010101 ---> "+response.statusCode.toString());
      // print("response 010101 ---> "+response.statusMessage);
      // print("response 010101 ---> "+response.data.toString());
      // final Map parsed = json.decode(response.data);

      if(response.statusCode >= 200 && response.statusCode <= 200)
      {
        print("if ----->");
        AddToWishListResponse wishListResponse = AddToWishListResponse.fromMap(response.data);
        print("response data --->"+wishListResponse.data.toString());
        print("response message --->"+wishListResponse.message.toString());
        print("response code --->"+wishListResponse.code.toString());

        return wishListResponse;
      }
      else{
        print("else ----->");
        AddToWishListResponse wishListResponse = AddToWishListResponse.fromMap(response.data);


        print(wishListResponse.toString());
        return wishListResponse;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }

  Future<DeleteFromWishList> deleteFromWishList(WishListRequest request) async {
    try {

      formData = new FormData.fromMap(request.toJson());
      print("response --------...... ---> "+ApiRoutesUpdate().getLink(ApiRoutes.deleteFromWishListUser(request)));

      Response response = await dio.delete(ApiRoutesUpdate().getLink(ApiRoutes.deleteFromWishListUser(request)), data: formData , options: options);

      print("99999 === >>> "+request.toJson().toString());
      // print("response 010101 ---> "+response.statusCode.toString());
      // print("response 010101 ---> "+response.statusMessage);
      // print("response 010101 ---> "+response.data.toString());
      // final Map parsed = json.decode(response.data);

      if(response.statusCode >= 200 && response.statusCode <= 200)
      {
        print("if ----->");
        DeleteFromWishList deleteFromWishList = DeleteFromWishList.fromMap(response.data);


        return deleteFromWishList;
      }
      else{
        print("else code----->"+response.statusCode.toString());
        print("else code----->"+response.statusMessage);
        DeleteFromWishList deleteFromWishList = DeleteFromWishList.fromMap(response.data);


        print(deleteFromWishList.toString());
        return deleteFromWishList;
        // return BaseResponse.fromMap(response.data);
      }
    } catch (error, stacktrace) {
      print("response 000 ");
      print("Exception occured: $error stackTrace: $stacktrace");
      return null;
    }
  }


}