// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:flutter/services.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/requests/chat/IntiateNewChatRequest.dart';
// import 'package:phinex/Bles/Model/requests/chat/NewMessageRequest.dart';
// import 'package:phinex/Bles/Model/responses/TestResponse.dart';
// import 'package:phinex/Bles/Model/responses/chat/ChatInfoResponse.dart';
// import 'package:phinex/Bles/Model/responses/chat/FriendsCount.dart';
// import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';
// import 'package:phinex/Bles/Model/responses/chat/MessageByChatResponse.dart';
// import 'package:phinex/Bles/Model/responses/chat/RecentChatResponse.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/base/BaseBloc.dart';
// import '../../ApiRoutes.dart';
//
// class ChatBloc extends BaseBloc {
//   BehaviorSubject<IntiateNewChatResponse> _chatResponse = BehaviorSubject<IntiateNewChatResponse>();
//   BehaviorSubject<MessageByChatResponse> _messageChatResponse = BehaviorSubject<MessageByChatResponse>();
//   BehaviorSubject<Messages> _message = BehaviorSubject<Messages>();
//   BehaviorSubject<List<Messages>> _messages = BehaviorSubject<List<Messages>>();
//   BehaviorSubject<RecentChatResponse> _recentchats = BehaviorSubject<RecentChatResponse>();
//   BehaviorSubject<Chat> _singleChat = BehaviorSubject<Chat>();
//   BehaviorSubject<List<Subscriptions>> _members = BehaviorSubject<List<Subscriptions>>();
//   BehaviorSubject<FriendsCountResponse> _friendsCount =  BehaviorSubject<FriendsCountResponse>();
//
//   ChatBloc() {
//     initPusher();
//   }
//
//   getResentChats(BaseRequestSkipTake request) async {
//     loading.value = true;
//     _recentchats.value = RecentChatResponse.fromMap((await repository.get(ApiRoutes.showRecentChat(request))).data);
//     loading.value = false;
//   }
//
//   getMessagesChat(BaseRequestSkipTake request) async {
//
//     print('>>>>> the api route ${repository.get(ApiRoutes.showMessagesChat(request))}');
//
//     // await subscribe(request.id);
//     // await bind();
//     if(request.skip == 0){
//       loading.value = true;
//
//       _messageChatResponse.value = MessageByChatResponse.fromMap((await repository.get(ApiRoutes.showMessagesChat(request))).data);
//
//       _messages.value = _messageChatResponse.value.data.messages.reversed.toList();
//       _members.value = _messageChatResponse.value.data.members;
//     }
//     else{
//       subLoading.value = true ;
//       _messageChatResponse.value = MessageByChatResponse.fromMap((await repository.get(ApiRoutes.showMessagesChat(request))).data);
//
//       _messages.value.addAll(_messageChatResponse.value.data.messages);
//       _messages.value = _messages.value.reversed.toList();
//     }
//     _singleChat.value = _messageChatResponse.value.data.chat;
//     _singleChat.value.subscriptions = _members.value;
//     _singleChat.value.messages = _messages.value;
//     _singleChat.value=_singleChat.value;
//     print("_singleChat.value");
//     print(_singleChat.value);
//     loading.value = false;
//     subLoading.value = false;
//   }
//
//   intiateNewChat(IntiateNewChatRequest request) async {
//     loading.value = true;
//
//     print(repository.postObject(ApiRoutes.newChat, request));
//
//     _chatResponse.value = IntiateNewChatResponse.fromMap((await repository.postObject(ApiRoutes.newChat, request)).data);
//
//     _singleChat.value = _chatResponse.value.data;
//     if(_singleChat.value != null) {
//       _singleChat.value.messages = _singleChat.value.messages.reversed.toList();
//       _singleChat.value = _singleChat.value;
//       subscribe(_singleChat.value.id);
//     }
//
//     loading.value = false;
//
//     return _chatResponse.value.data.id;
//   }
//
//   addNewMessage(NewMessageRequest request) async {
//     _message.value = Messages(chatId: request.chat_id , userId: request.user_id,
//       content: request.content, createdAt: DateTime.now().toString()
//     );
//
//     _singleChat.value.messages.add(_message.value);
//     _singleChat.value = _singleChat.value;
//
//
//     Response response = await repository.postUpload(ApiRoutes.newMessageToChat(request.chat_id),await request.toJson());
//     print("response ---->>>> "+response.statusMessage);
//   }
//
//   showChatInfo(int chatID) async {
//     _singleChat.value = ChatInfoResponse.fromMap((await repository.get(ApiRoutes.showChatInfo(chatID))).data).data;
//   }
//
//   getFriendsCount(int userId) async {
//     loading.value = true;
//     _friendsCount.value = FriendsCountResponse.fromJson((await repository.get(ApiRoutes.getFriendsRequestCount(userId))).data);
//     loading.value = false;
//   }
//
//   @override
//   dispose() {
//     super.dispose();
//
//     _chatResponse.close();
//     _message.close();
//   }
//
//   @override
//   clear() {
//     super.clear();
//     _chatResponse = BehaviorSubject<IntiateNewChatResponse>();
//     _message = BehaviorSubject<Messages>();
//   }
//
//   BehaviorSubject<Chat> get chat => _singleChat;
//   BehaviorSubject<RecentChatResponse> get chats => _recentchats;
//   BehaviorSubject<Messages> get message => _message;
//   BehaviorSubject<FriendsCountResponse> get friendsCount =>  _friendsCount;
//
//   Event lastEvent;
//   String lastConnectionState;
//   Channel channel;
//   String appKey = "JK123456";
//   String channelName = "private-chat.";
//   String channelBaseName = "private-chat.";
//   String eventName = "App\\Events\\MessageSent";
//   String authLink = "https://developers.api.phinex.net/v-1872020/eg-en/chatting/broadcasting/auth";
//   String cluster = "eu";
//   String host ="synchronizer.phinex.net";
//   int port = 6001;
//   bool encrypted = false;
//   bool logging = true;
//
//   Future<void> initPusher() async {
//     try {
//       await Pusher.init(appKey, PusherOptions(
//         auth: PusherAuth(authLink),
//         cluster: cluster,
//         host: host,
//         port: port,
//         encrypted: encrypted,
//       ),
//           enableLogging: logging,
//       );
//
//       await connect();
//
//     } on PlatformException catch (e) {
//
//       print("platform exeption ------------------->   ");
//       print(e.message);
//     }
//   }
//
//   connect () {
//     Pusher.connect(onConnectionStateChange: (x) async {
//
//       lastConnectionState = x.currentState;
//       debugPrint("in connection --->> >> ");
//
//     }, onError: (x) {
//       debugPrint("Error in connection --->> >> : ${x.message}");
//     });
//   }
//
//   disconnect() {
//     Pusher.disconnect();
//   }
//
//   bind() async {
//
//     await channel.bind(this.eventName, (x) {
//       lastEvent = x;
//       Messages message = TestResponse.fromMap(json.decode(lastEvent.data)).message;
//       if(message.userId.toString() == AppUtils.userData.id.toString()){
//         return;
//       }
//       _singleChat.value.messages.add(message);
//       _singleChat.value = _singleChat.value;
//     });
//   }
//
//   unbind() async {
//     await channel.unbind(eventName);
//   }
//
//   subscribe(int chatID) async {
//     debugPrint("subscribe --->> >> ");
//     channel = await Pusher.subscribe(channelBaseName+chatID.toString());
//   }
//
//   unsubscribe(int chatID) async {
//     await Pusher.unsubscribe(channelBaseName+chatID.toString());
//   }
// }
//
// var chatBloc = ChatBloc();
