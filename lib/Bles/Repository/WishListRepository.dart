import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/Model/responses/wish_list/add_to_wishlist/AddToWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/delete_from_wishlist/DeleteFromWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';
import 'package:phinex/Bles/api_provider/wish_list/WishListApiProvider.dart';

class WishListRepository {
  WishListApiProvider _apiProvider = WishListApiProvider();

  Future<WishListResponse> getWishListUser(int userId) {
    return _apiProvider.getWishListUser(userId);
  }

  Future<AddToWishListResponse> addToWishList(WishListRequest request) {
    return _apiProvider.addToWishList(request);
  }

  Future<DeleteFromWishList> deleteFromWishList(WishListRequest request) {
    return _apiProvider.deleteFromWishList(request);
  }
}
