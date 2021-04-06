import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/requests/social/AddGalleryRequest.dart';
import 'package:phinex/Bles/Model/requests/social/AddNewFriendRequest.dart';
import 'package:phinex/Bles/Model/requests/social/UpdateUserProfile.dart';
import 'package:phinex/Bles/Model/responses/social/FriendsListResponse.dart';
import 'package:phinex/Bles/Model/responses/social/SearchUserResponse.dart';
import 'package:phinex/Bles/Model/responses/social/ShowFriendShipRequestsResponse.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';

import '../../ApiRoutes.dart';

class SocialBloc extends BaseBloc {
  BehaviorSubject<UserProfileResponse> _userProfile = BehaviorSubject<
      UserProfileResponse>();
  BehaviorSubject<ShowFriendShipRequestsResponse> _showFriendsRequest = BehaviorSubject<ShowFriendShipRequestsResponse>();
  BehaviorSubject<FriendsListResponse> _showFriendsList = BehaviorSubject<FriendsListResponse>();
  BehaviorSubject<Response> _addFriendRequest = BehaviorSubject<Response>();
  BehaviorSubject<Response> _cancelFriendRequest = BehaviorSubject<Response>();
  BehaviorSubject<Response> _acceptFriendRequest = BehaviorSubject<Response>();
  BehaviorSubject<Response> _deleteFriendRequest = BehaviorSubject<Response>();
  BehaviorSubject<Response> _updateUserProfile = BehaviorSubject<Response>();
  BehaviorSubject<Response> _addGalleryToUser = BehaviorSubject<Response>();
  BehaviorSubject<bool> imageLoading = BehaviorSubject<bool>();

  // BehaviorSubject<SearchUserResponse> _searchUser =BehaviorSubject<SearchUserResponse>();


  Future<Response> updateUserProfile(UpdateUserProfileRequest request) async {
   var response = repository.put(ApiRoutes.updateUserProfile(request.userId), request.toJson());
   return response;
  }
  Future<Response> updateUserPassword(UpdateUserProfileRequest request) async {
   var response = repository.patch(ApiRoutes.updatePassword(request.userId), request.toJsonPassword());
   return response;
  }

  updateUserProfileImage(UpdateUserProfileRequest request) async {
    repository.put(ApiRoutes.updateUserProfile(request.userId), request.toJsonImage());
  }

  updateUserProfileCoverImage(UpdateUserProfileRequest request) async {
    repository.put(ApiRoutes.updateUserProfile(request.userId),
        request.toJsonCoverImage());
  }

  addGalleryToUser(AddGalleryRequest request) async {
    imageLoading.value = true;
    Response response = await repository.post(
        ApiRoutes.addImageToUserGallery(request.userID), request.toJson());
    imageLoading.value = false;
  }

  getUserProfile(int userID) async {
    loading.value = true;
    _userProfile.value = UserProfileResponse.fromMap(
        (await repository.get(ApiRoutes.userProfile(userID))).data);

    
    loading.value = false;
  }

  getshowFriendsRequests(int userID) async {
    loading.value = true;
    _showFriendsRequest.value = ShowFriendShipRequestsResponse.fromMap(
        (await repository.get(ApiRoutes.showFriendsRequests(userID))).data);
    loading.value = false;
  }

  getshowFriendsList(BaseRequestSkipTake request) async {
    loading.value = true;
    _showFriendsList.value = FriendsListResponse.fromMap(
        (await repository.get(ApiRoutes.showFriendList(request))).data);
    loading.value = false;
  }

  addFriendRequest(AddNewFriendRequest request) async {
    // loading.value = true;
    _addFriendRequest.value =
    await repository.post(ApiRoutes.addNewFriend, request.toJson());
    // loading.value = false;
  }

  cancelFriendRequest(int userID, int friendID) async {
    // loading.value = true;
    _cancelFriendRequest.value =
    await repository.delete(ApiRoutes.cancelFriendRequest(userID, friendID));
    // loading.value = false;
  }

  acceptFriendRequest(int userID, int friendID) async {
    // loading.value = true;
    _acceptFriendRequest.value = await repository.post(
        ApiRoutes.acceptFriendRequest(userID, friendID), null);
    // loading.value = false;
  }

  deleteFriendShipt(int userID, int friendID) async {
    // loading.value = true;
    print(friendID);
    _deleteFriendRequest.value =
    await repository.delete(ApiRoutes.deleteFriendRequest(userID, friendID));
    // loading.value = false;
  }


  searchUser(SearchRequest request) async {
    loading.value = true;
    var response = SearchUserResponse.fromMap((await repository.post(ApiRoutes.searchUser(request), request.tojson())).data).data;
    _showFriendsList.value.data = response;
    _showFriendsList.value = _showFriendsList.value;
    loading.value = false;
  }


  @override
  dispose() {
    super.dispose();
    _userProfile.close();
    _showFriendsRequest.close();
    _showFriendsList.close();
    _addFriendRequest.close();
    _cancelFriendRequest.close();
    _acceptFriendRequest.close();
    _deleteFriendRequest.close();
  }

  @override
  clear() {
    super.clear();
    _userProfile = BehaviorSubject<UserProfileResponse>();
    _showFriendsRequest = BehaviorSubject<ShowFriendShipRequestsResponse>();
    _showFriendsList = BehaviorSubject<FriendsListResponse>();
    _addFriendRequest = BehaviorSubject<Response>();
    _cancelFriendRequest = BehaviorSubject<Response>();
    _acceptFriendRequest = BehaviorSubject<Response>();
    _deleteFriendRequest = BehaviorSubject<Response>();
  }

  BehaviorSubject<UserProfileResponse> get userProfile => _userProfile;

  BehaviorSubject<ShowFriendShipRequestsResponse> get showFriendsRequest => _showFriendsRequest;

  BehaviorSubject<FriendsListResponse> get showFriendsList => _showFriendsList;

  BehaviorSubject<Response> get addFriend => _addFriendRequest;

  BehaviorSubject<Response> get cancelFriend => _cancelFriendRequest;

  BehaviorSubject<Response> get acceptFriend => _acceptFriendRequest;

  BehaviorSubject<Response> get deleteFriendRequest => _deleteFriendRequest;
}

var socialBloc = SocialBloc();
