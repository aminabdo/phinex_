// import 'package:flutter/material.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/responses/chat/RecentChatResponse.dart';
// import 'package:phinex/Bles/bloc/social/ChatBloc.dart';
// import 'package:phinex/ui/views/chats/firends/private_single_chat_page.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
// import 'package:time_ago_provider/time_ago_provider.dart' as TimeAgo;
//
//
// class MembersPage extends StatefulWidget {
//   @override
//   _MembersPageState createState() => _MembersPageState();
// }
//
// class _MembersPageState extends State<MembersPage> {
//   int take = 30;
//   int skip = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     chatBloc.getResentChats(BaseRequestSkipTake(
//       skip: skip,
//       take: take,
//       id: AppUtils.userData.id,
//     ));
//   }
//
//   ScrollController _scrollController = ScrollController();
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<RecentChatResponse>(
//       stream: chatBloc.chats.stream,
//       builder: (context, snapshot) {
//         if (chatBloc.loading.value) {
//           return Loader();
//         } else {
//           _scrollController
//             ..addListener(
//               () {
//                 if (_scrollController.position.pixels ==
//                     _scrollController.position.maxScrollExtent) {
//                   skip = 0;
//                   take = 30;
//                   chatBloc.getResentChats(
//                     BaseRequestSkipTake(
//                       skip: skip,
//                       take: take,
//                       id: AppUtils.userData.id,
//                     ),
//                   );
//                 }
//               },
//             );
//           return ListView.builder(
//             controller: _scrollController,
//             physics: bouncingScrollPhysics,
//             itemBuilder: (context, index) {
//               var currentChat = snapshot.data.data[index];
//               String title = '';
//               if (currentChat.subscriptions.length <= 2) {
//                 if (currentChat.subscriptions[0].id == AppUtils.userData.id) {
//                   title = currentChat.subscriptions[1].username;
//                 } else {
//                   title = currentChat.subscriptions[0].username;
//                 }
//               } else {
//                 title = currentChat.title;
//               }
//               return ListTile(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => PrivateChatPage(
//                         name: currentChat.title,
//                         id: currentChat.id,
//                       ),
//                     ),
//                   );
//                 },
//                 title: Text(
//                   title,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: currentChat.lastMessage == null ? SizedBox.shrink() : Text(
//                   currentChat.lastMessage.attachment == null ? currentChat.lastMessage?.content ?? "" : currentChat.lastMessage.attachment.type == 'image' ? 'New Image' : 'New Video',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green),
//                 ),
//                 trailing: Text(
//                   TimeAgo.format(DateTime.parse(snapshot.data.data[index].createdAt)),
//                   style: TextStyle(color: Colors.grey),
//                 ),
//                 leading: Stack(
//                   overflow: Overflow.visible,
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/avatar.png'),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             itemCount: snapshot.data.data.length,
//           );
//         }
//       },
//     );
//   }
// }
