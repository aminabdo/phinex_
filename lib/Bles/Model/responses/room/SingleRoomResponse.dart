
import 'dart:io';

class SingleRoomResponse {
  DataBean data;
  dynamic message;
  int code;

  static SingleRoomResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SingleRoomResponse singleRoomResponseBean = SingleRoomResponse();
    singleRoomResponseBean.data = DataBean.fromMap(map['data']);
    singleRoomResponseBean.message = map['message'];
    singleRoomResponseBean.code = map['code'];
    return singleRoomResponseBean;
  }

  Map toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}

class DataBean {
  RoomBean room;
  List<SuggestedAdminRoomsBean> suggestedAdminRooms;
  List<SuggestedUsersRoomsBean> suggestedUsersRooms;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean dataBean = DataBean();
    dataBean.room = RoomBean.fromMap(map['room']);
    dataBean.suggestedAdminRooms = List()..addAll(
      (map['suggestedAdminRooms'] as List ?? []).map((o) => SuggestedAdminRoomsBean.fromMap(o))
    );
    dataBean.suggestedUsersRooms = List()..addAll(
      (map['suggestedUsersRooms'] as List ?? []).map((o) => SuggestedUsersRoomsBean.fromMap(o))
    );
    return dataBean;
  }

  Map toJson() => {
    "room": room,
    "suggestedAdminRooms": suggestedAdminRooms,
    "suggestedUsersRooms": suggestedUsersRooms,
  };
}

/// id : 9
/// name : "hgd"
/// creator_id : 212
/// featured : 0
/// image_id : null
/// creator_type : "user"
/// created_at : "2020-12-15 15:35:16"

class SuggestedUsersRoomsBean {
  int id;
  String name;
  int creatorId;
  int featured;
  dynamic imageId;
  String creatorType;
  String createdAt;

  static SuggestedUsersRoomsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SuggestedUsersRoomsBean suggestedUsersRoomsBean = SuggestedUsersRoomsBean();
    suggestedUsersRoomsBean.id = map['id'];
    suggestedUsersRoomsBean.name = map['name'];
    suggestedUsersRoomsBean.creatorId = map['creator_id'];
    suggestedUsersRoomsBean.featured = map['featured'];
    suggestedUsersRoomsBean.imageId = map['image_id'];
    suggestedUsersRoomsBean.creatorType = map['creator_type'];
    suggestedUsersRoomsBean.createdAt = map['created_at'];
    return suggestedUsersRoomsBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "featured": featured,
    "image_id": imageId,
    "creator_type": creatorType,
    "created_at": createdAt,
  };
}

/// id : 1
/// name : "admin room 1"
/// creator_id : 1
/// featured : 0
/// image_id : null
/// creator_type : "admin"
/// created_at : "2020-12-14 15:36:13"

class SuggestedAdminRoomsBean {
  int id;
  String name;
  int creatorId;
  int featured;
  dynamic imageId;
  String creatorType;
  String createdAt;

  static SuggestedAdminRoomsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SuggestedAdminRoomsBean suggestedAdminRoomsBean = SuggestedAdminRoomsBean();
    suggestedAdminRoomsBean.id = map['id'];
    suggestedAdminRoomsBean.name = map['name'];
    suggestedAdminRoomsBean.creatorId = map['creator_id'];
    suggestedAdminRoomsBean.featured = map['featured'];
    suggestedAdminRoomsBean.imageId = map['image_id'];
    suggestedAdminRoomsBean.creatorType = map['creator_type'];
    suggestedAdminRoomsBean.createdAt = map['created_at'];
    return suggestedAdminRoomsBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "featured": featured,
    "image_id": imageId,
    "creator_type": creatorType,
    "created_at": createdAt,
  };
}

/// id : 13
/// name : "admin room 1"
/// creator_id : 2
/// featured : 0
/// image_id : 3811
/// creator_type : "user"
/// created_at : "2020-12-22 14:19:53"
/// posts : []
/// image_url : "https://images.tbdm.net/storage/app/public/images/2020-12/22-Tue/room-image-1608647444.png"
/// creator_data : {"image_url":"https://images.tbdm.net/storage/app/public/images/2020-12/17-Thu/israa1608194795.gif","username":"israa tharwat"}

class RoomBean {
  int id;
  String name;
  int creatorId;
  int featured;
  int imageId;
  String creatorType;
  String createdAt;
  List<Post> posts;
  String imageUrl;
  Creator_dataBean creatorData;

  static RoomBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RoomBean roomBean = RoomBean();
    roomBean.id = map['id'];
    roomBean.name = map['name'];
    roomBean.creatorId = map['creator_id'];
    roomBean.featured = map['featured'];
    roomBean.imageId = map['image_id'];
    roomBean.creatorType = map['creator_type'];
    roomBean.createdAt = map['created_at'];
    roomBean.posts = List()..addAll(
        (map['posts'] as List ?? []).map((o) => Post.fromMap(o))
    );
    roomBean.imageUrl = map['image_url'];
    roomBean.creatorData = Creator_dataBean.fromMap(map['creator_data']);
    return roomBean;
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "featured": featured,
    "image_id": imageId,
    "creator_type": creatorType,
    "created_at": createdAt,
    "posts": posts,
    "image_url": imageUrl,
    "creator_data": creatorData,
  };
}

/// image_url : "https://images.tbdm.net/storage/app/public/images/2020-12/17-Thu/israa1608194795.gif"
/// username : "israa tharwat"

class Creator_dataBean {
  String imageUrl;
  String username;

  static Creator_dataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Creator_dataBean creator_dataBean = Creator_dataBean();
    creator_dataBean.imageUrl = map['image_url'];
    creator_dataBean.username = map['username'];
    return creator_dataBean;
  }

  Map toJson() => {
    "image_url": imageUrl,
    "username": username,
  };
}



class Post {
  int id;
  int roomId;
  int userId;
  String postBody;
  String createdAt;
  AttachmentBean attachment;
  User_dataBean userData;
  File attachFile ;


  Post({this.id, this.roomId, this.userId, this.postBody, this.createdAt,
      this.attachment, this.userData ,this.attachFile});

  static Post fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Post testBean = Post();
    testBean.id = map['id'];
    testBean.roomId = map['room_id'];
    testBean.userId = map['user_id'];
    testBean.postBody = map['post_body'];
    testBean.createdAt = map['created_at'];
    testBean.attachment = AttachmentBean.fromMap(map['attachment']);
    testBean.userData = User_dataBean.fromMap(map['user_data']);
    return testBean;
  }

  Map toJson() => {
    "id": id,
    "room_id": roomId,
    "user_id": userId,
    "post_body": postBody,
    "created_at": createdAt,
    "attachment": attachment,
    "user_data": userData,
  };
}

/// image_url : null
/// username : "jj sss"

class User_dataBean {
  dynamic imageUrl;
  String username;

  static User_dataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User_dataBean user_dataBean = User_dataBean();
    user_dataBean.imageUrl = map['image_url'];
    user_dataBean.username = map['username'];
    return user_dataBean;
  }

  Map toJson() => {
    "image_url": imageUrl,
    "username": username,
  };
}

/// id : 6
/// post_id : 36
/// content : "https://funvideos.tbdm.net/storage/app/public/attachments/2020-12/24-Thu/e83d1e5bc63b7aea55a27f187ea4a24649c7600b.png"
/// type : "image"
/// created_at : "2020-12-24 10:17:59"

class AttachmentBean {
  int id;
  int postId;
  String content;
  String type;
  String createdAt;

  AttachmentBean({this.id, this.postId, this.content, this.type, this.createdAt});

  static AttachmentBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AttachmentBean attachmentBean = AttachmentBean();
    attachmentBean.id = map['id'];
    attachmentBean.postId = map['post_id'];
    attachmentBean.content = map['content'];
    attachmentBean.type = map['type'];
    attachmentBean.createdAt = map['created_at'];
    return attachmentBean;
  }

  Map toJson() => {
    "id": id,
    "post_id": postId,
    "content": content,
    "type": type,
    "created_at": createdAt,
  };
}