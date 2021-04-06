import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/wish_list/AddToWishListRequest.dart';
import 'package:phinex/Bles/Model/responses/wish_list/add_to_wishlist/AddToWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/delete_from_wishlist/DeleteFromWishList.dart';
import 'package:phinex/Bles/Model/responses/wish_list/wish_list_by_user/WishListResponse.dart';
import 'package:phinex/Bles/Repository/WishListRepository.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

class WishListBloc extends BaseBloc{
  final WishListRepository _repository = WishListRepository();

  BehaviorSubject<WishListResponse> _wishListUser = BehaviorSubject<WishListResponse>();
  BehaviorSubject<AddToWishListResponse> _add_to_wishlist = BehaviorSubject<AddToWishListResponse>();
  BehaviorSubject<DeleteFromWishList> _delete_wishlist = BehaviorSubject<DeleteFromWishList>();
  BehaviorSubject<int> _wishlistCounter = BehaviorSubject<int>();

  getWishListUser(int userID) async {
    loading.value = true;

    WishListResponse response = await _repository.getWishListUser(userID);

    _wishListUser.value = response;

    _wishlistCounter.value = _wishListUser.value.data.length;

    loading.value = false;

  }

  addToWishList(WishListRequest request) async {

    _wishlistCounter.value ++;
    AddToWishListResponse response = await _repository.addToWishList(request);
    _add_to_wishlist.value = response;
  }

  deleteFromWishList(WishListRequest request) async {

    _wishlistCounter.value --;
    DeleteFromWishList response = await _repository.deleteFromWishList(request);
    _delete_wishlist.value = response;


  }

  dispose() {
    _wishListUser.close();
    _add_to_wishlist.close();
    _delete_wishlist.close();
  }

  clear() {

    _wishListUser = BehaviorSubject<WishListResponse>();
    _add_to_wishlist = BehaviorSubject<AddToWishListResponse>();
    _delete_wishlist = BehaviorSubject<DeleteFromWishList>();
  }

  BehaviorSubject<WishListResponse> get wishList =>  _wishListUser;
  BehaviorSubject<AddToWishListResponse> get addWishList => _add_to_wishlist;
  BehaviorSubject<DeleteFromWishList> get deleteWishList => _delete_wishlist;
  BehaviorSubject<int> get wishlistCounter => _wishlistCounter;

}
// amin
final wishlistBloc = WishListBloc();