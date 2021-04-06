import 'dart:convert';

RoomLandingResponse roomLandingResponseFromJson(String str) => RoomLandingResponse.fromJson(json.decode(str));

String roomLandingResponseToJson(RoomLandingResponse data) => json.encode(data.toJson());

class RoomLandingResponse {
  RoomLandingResponse({
    this.data,
    this.message,
    this.code,
  });

  Data data;
  dynamic message;
  int code;

  factory RoomLandingResponse.fromJson(Map<String, dynamic> json) => RoomLandingResponse(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "code": code,
  };
}

class Data {
  Data({
    this.adminsRooms,
    this.usersRooms,
  });

  List<Room> adminsRooms;
  List<Room> usersRooms;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    adminsRooms: List<Room>.from(json["admins-rooms"].map((x) => Room.fromJson(x))),
    usersRooms: List<Room>.from(json["users-rooms"].map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "admins-rooms": List<dynamic>.from(adminsRooms.map((x) => x.toJson())),
    "users-rooms": List<dynamic>.from(usersRooms.map((x) => x.toJson())),
  };
}

class Room {
  Room({
    this.id,
    this.name,
    this.creatorId,
    this.featured,
    this.creatorType,
  });

  int id;
  String name;
  int creatorId;
  int featured;
  String creatorType;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    id: json["id"],
    name: json["name"],
    creatorId: json["creator_id"],
    featured: json["featured"],
    creatorType: json["creator_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "creator_id": creatorId,
    "featured": featured,
    "creator_type": creatorType,
  };
}