// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:pusher_websocket_flutter/pusher.dart';
//
// class ChatListener{
//   Event lastEvent;
//   String lastConnectionState;
//   Channel channel;
//   String appKey = "JK123456";
//   String channelName = "private-chat.54";
//   String channelBaseName = "private-chat.";
//   String eventName = "App\\Events\\MessageSent";
//   String authLink = "https://developers.api.tbdm.net/v-1872020/eg-en/chatting/broadcasting/auth";
//   String cluster = "eu";
//   String host ="synchronizer.tbdm.net";
//   int port = 6001;
//   bool encrypted = false;
//   bool logging = true;
//
//   ChatListener(
//       {this.appKey="JK123456",
//         this.channelName="private-chat.54",
//         this.eventName="App\\Events\\MessageSent",
//         this.authLink = "https://developers.api.tbdm.net/v-1872020/eg-en/chatting/broadcasting/auth",
//         this.cluster= "eu",
//         this.host ="synchronizer.tbdm.net",
//         this.port=6001,
//         this.encrypted=false,
//         this.logging=true}
//       ){
//     initPusher();
//   }
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
//           enableLogging: logging);
//
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
//     await channel.bind(eventName, (x) {
//       lastEvent = x;
//     });
//   }
//
//   unbind() async{
//     await channel.unbind(eventName);
//   }
//
//   subscribe() async {
//     channel = await Pusher.subscribe(channelName);
//   }
//
//   unsubscribe() async {
//     await Pusher.unsubscribe(channelName);
//   }
//
// }