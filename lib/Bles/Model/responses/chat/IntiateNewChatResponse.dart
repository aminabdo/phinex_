import 'package:dio/dio.dart';
import 'package:phinex/utils/base/BaseResponse.dart';

class IntiateNewChatResponse extends BaseResponse {
  Chat data;
  dynamic message;
  int code;

  static IntiateNewChatResponse fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IntiateNewChatResponse intiateNewChatResponseBean = IntiateNewChatResponse();
    intiateNewChatResponseBean.data = Chat.fromMap(map['data']);
    intiateNewChatResponseBean.message = map['message'];
    intiateNewChatResponseBean.code = map['code'];
    return intiateNewChatResponseBean;
  }

  Map toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}

class Chat extends Response {
  int id;
  String title;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<Subscriptions> subscriptions;
  List<Messages> messages;
  LastMessage lastMessage;

  static Chat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Chat dataBean = Chat();
    dataBean.id = map['id'];
    dataBean.title = map['title'];
    dataBean.createdAt = map['created_at'];
    dataBean.updatedAt = map['updated_at'];
    dataBean.deletedAt = map['deleted_at'];
    dataBean.lastMessage = LastMessage.fromJson(map['last-message']);
    dataBean.subscriptions = List()..addAll((map['subscriptions'] as List ?? []).map((o) => Subscriptions.fromMap(o)));
    dataBean.messages = List()..addAll((map['messages'] as List ?? []).map((o) => Messages.fromMap(o)));
    return dataBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "subscriptions": subscriptions,
        "messages": messages,
        "last-message": lastMessage,
      };
}

class LastMessage {
  int id;
  int chatId;
  int userId;
  String content;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  Attachment attachment;

  LastMessage(
      {this.id,
        this.chatId,
        this.userId,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.attachment,
      });

  LastMessage.fromJson(Map<String, dynamic> json) {
    if(json == null) return;
    id = json['id'];
    chatId = json['chat_id'];
    userId = json['user_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    attachment = json['attachment'] != null ? new Attachment.fromJson(json['attachment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chat_id'] = this.chatId;
    data['user_id'] = this.userId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.attachment != null) {
      data['attachment'] = this.attachment.toJson();
    }
    return data;
  }
}

class Attachment {
  int id;
  int messageId;
  String content;
  String type;
  String createdAt;

  Attachment(
      {this.id, this.messageId, this.content, this.type, this.createdAt});

  Attachment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    content = json['content'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['content'] = this.content;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class  Messages {
  dynamic id;
  dynamic chatId;
  dynamic userId;
  String content;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  AttachmentBean attachment;

  Messages({
    this.id,
    this.chatId,
    this.userId,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.attachment,
  });

  static Messages fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Messages testBean = Messages();
    testBean.id = map['id'];
    testBean.chatId = map['chat_id'];
    testBean.userId = map['user_id'];
    testBean.content = map['content'];
    testBean.createdAt = map['created_at'];
    testBean.updatedAt = map['updated_at'];
    testBean.deletedAt = map['deleted_at'];
    testBean.attachment = AttachmentBean.fromMap(map['attachment']);
    return testBean;
  }

  Map toJson() => {
        "id": id,
        "chat_id": chatId,
        "user_id": userId,
        "content": content,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "attachment": attachment,
      };
}

class AttachmentBean {
  dynamic id;
  dynamic messageId;
  String content;
  String type;
  String createdAt;

  static AttachmentBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AttachmentBean attachmentBean = AttachmentBean();
    attachmentBean.id = map['id'];
    attachmentBean.messageId = map['message_id'];
    attachmentBean.content = map['content'];
    attachmentBean.type = map['type'];
    attachmentBean.createdAt = map['created_at'];
    return attachmentBean;
  }

  Map toJson() => {
        "id": id,
        "message_id": messageId,
        "content": content,
        "type": type,
        "created_at": createdAt,
      };
}

class Subscriptions {
  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String verificationCode;
  String apiToken;
  dynamic phoneVerifiedAt;
  String type;
  String chanel;
  dynamic details;

  static Subscriptions fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Subscriptions subscriptionsBean = Subscriptions();
    subscriptionsBean.id = map['id'];
    subscriptionsBean.firstName = map['first_name'];
    subscriptionsBean.lastName = map['last_name'];
    subscriptionsBean.username = map['username'];
    subscriptionsBean.phone = map['phone'];
    subscriptionsBean.verificationCode = map['verification_code'];
    subscriptionsBean.apiToken = map['api_token'];
    subscriptionsBean.phoneVerifiedAt = map['phone_verified_at'];
    subscriptionsBean.type = map['type'];
    subscriptionsBean.chanel = map['chanel'];
    subscriptionsBean.details = map['details'];
    return subscriptionsBean;
  }

  Map toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "phone": phone,
        "verification_code": verificationCode,
        "api_token": apiToken,
        "phone_verified_at": phoneVerifiedAt,
        "type": type,
        "chanel": chanel,
        "details": details,
      };
}

class Details {
  int userId;
  dynamic imageId;
  dynamic email;
  String country;
  String governorate;
  String city;
  String address;
  dynamic addressLatitude;
  dynamic addressLongitude;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;

  static Details fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Details testResponseBean = Details();
    testResponseBean.userId = map['user_id'];
    testResponseBean.imageId = map['image_id'];
    testResponseBean.email = map['email'];
    testResponseBean.country = map['country'];
    testResponseBean.governorate = map['governorate'];
    testResponseBean.city = map['city'];
    testResponseBean.address = map['address'];
    testResponseBean.addressLatitude = map['address_latitude'];
    testResponseBean.addressLongitude = map['address_longitude'];
    testResponseBean.deletedAt = map['deleted_at'];
    testResponseBean.createdAt = map['created_at'];
    testResponseBean.updatedAt = map['updated_at'];
    return testResponseBean;
  }

  Map toJson() => {
        "user_id": userId,
        "image_id": imageId,
        "email": email,
        "country": country,
        "governorate": governorate,
        "city": city,
        "address": address,
        "address_latitude": addressLatitude,
        "address_longitude": addressLongitude,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
