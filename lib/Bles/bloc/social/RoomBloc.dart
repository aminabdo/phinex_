import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:phinex/Bles/Model/requests/chat/RoomPostRequest.dart';
import 'package:phinex/Bles/Model/responses/room/MakeNewPostResponse.dart';
import 'package:phinex/Bles/Model/responses/room/RoomLandingResponse.dart';
import 'package:phinex/Bles/Model/responses/room/SingleRoomResponse.dart';
import 'package:phinex/utils/base/BaseBloc.dart';
import 'package:phinex/utils/consts.dart';

import '../../ApiRoutes.dart';

class RoomBloc extends BaseBloc {
  BehaviorSubject<RoomLandingResponse> _roomLandingResponse =
      BehaviorSubject<RoomLandingResponse>();
  BehaviorSubject<SingleRoomResponse> _singleRoomResponse =
      BehaviorSubject<SingleRoomResponse>();
  BehaviorSubject<Post> _singlePost = BehaviorSubject<Post>();

  getRoomLanding() async {
    loading.value = true;
    _roomLandingResponse.value = RoomLandingResponse.fromJson(
        (await repository.get(ApiRoutes.getRoomLanding())).data);
    loading.value = false;
  }

  getSingleRoom(int roomId) async {
    loading.value = true;
    _singleRoomResponse.value = SingleRoomResponse.fromMap(
        (await repository.get(ApiRoutes.getSingleRoom(roomId))).data);
    loading.value = false;
  }

  addNewMessage(RoomPostRequest request) async {
    _singleRoomResponse.value.data.room.posts.insert(
        0,
        Post(
          roomId: int.parse(request.roomId.toString()),
          postBody: request.postBody,
          userId: request.postSenderId,
          id: -10,
          attachFile: request.attachment,
          createdAt: DateTime.now().toString(),
        ));
    _singleRoomResponse.value = _singleRoomResponse.value;

    MakeNewPostToRoomResponse res = MakeNewPostToRoomResponse.fromJson(
        (await (repository.postUpload(
                ApiRoutes.makePostInSingleRoom(), await request.toJson())))
            .data);
  }

  createRoom(int creatorId, String roomName, {File imageFile}) async {
    await (repository.post(
      ApiRoutes.createRoom(),
      {
        "creator_id": creatorId,
        "name": roomName,
        "image": imageFile != null ? imageToString(imageFile) : "",
      },
    ));
  }

  updateRoom(int roomId, String newName) async {
    loading.value = true;
    await (repository.post(
      ApiRoutes.updateRoom(roomId),
      {"name": newName},
    ));
    loading.value = false;
  }

  @override
  dispose() {
    super.dispose();

    _roomLandingResponse.close();
    _singleRoomResponse.close();
  }

  @override
  clear() {
    super.clear();
    _roomLandingResponse = BehaviorSubject<RoomLandingResponse>();
    _singleRoomResponse = BehaviorSubject<SingleRoomResponse>();
  }

  BehaviorSubject<RoomLandingResponse> get roomLanding => _roomLandingResponse;

  BehaviorSubject<SingleRoomResponse> get singleRoom => _singleRoomResponse;
}

var roomBloc = RoomBloc();
