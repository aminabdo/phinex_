// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:phinex/Bles/Model/responses/TestResponse.dart';
// import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';
// import '../app_utils.dart';
//
//
//
// class BasePusher{
//
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
//   Future<void> initPusher({String appKey,String authLink, String cluster,String host, int port,bool encrypted}) async {
//     try {
//       await Pusher.init(appKey, PusherOptions(
//         auth: PusherAuth(authLink),
//         cluster: cluster,
//         host: host,
//         port: port,
//         encrypted: encrypted,
//       ),
//           enableLogging: logging);
//
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
//   connect (){
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
//   disconnect(){
//     Pusher.disconnect();
//   }
//
//   bind() async{
//     debugPrint("before binding --->> >> ");
//
//     await channel.bind(this.eventName, (x) {
//       debugPrint(" binding --->> >> ");
//       lastEvent = x;
//       debugPrint(" last event --->> >> "+lastEvent.data);
//       Messages message = TestResponse.fromMap(json.decode(lastEvent.data)).message;
//       debugPrint(" senderID --->> >> "+message.userId.toString());
//       if(message.userId.toString() == AppUtils.userData.id.toString()){
//         return;
//       }
//     });
//   }
//
//   unbind() async{
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