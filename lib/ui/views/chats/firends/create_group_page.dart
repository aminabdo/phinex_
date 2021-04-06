// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/requests/chat/IntiateNewChatRequest.dart';
// import 'package:phinex/Bles/Model/responses/social/FriendsListResponse.dart';
// import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
// import 'package:phinex/Bles/bloc/social/ChatBloc.dart';
// import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
// import 'package:phinex/ui/views/chats/firends/friends_provider.dart';
// import 'package:phinex/ui/widgets/my_app_bar.dart';
// import 'package:phinex/ui/widgets/my_button2.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
//
// import 'private_single_chat_page.dart';
//
// class CreateGroupPage extends StatefulWidget {
//   @override
//   _CreateGroupPageState createState() => _CreateGroupPageState();
// }
//
// class _CreateGroupPageState extends State<CreateGroupPage> {
//   bool isLoading = false;
//
//   TextEditingController nameController = TextEditingController();
//
//   bool showNameError = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     socialBloc.getshowFriendsList(
//       BaseRequestSkipTake(skip: 0, take: 1000, id: AppUtils.userData.id),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var friendsProvider = Provider.of<FriendsProvider>(context);
//     return Scaffold(
//       appBar: myAppBar(
//         'Create Group',
//         context,
//         onBackBtnClicked: () {
//           Navigator.pop(context);
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(12.0),
//         child: myButton2(
//           isLoading ? Loader(size: 30,) : Text('Create', style: TextStyle(color: Colors.white),),
//           onTap: () async {
//             if(nameController.text.isEmpty) {
//               setState(() {
//                 showNameError = true;
//               });
//               return;
//             } else if(friendsProvider.selectedFriends.length < 2){
//                 AppUtils.showToast(msg: 'Group must be least 2 members with you');
//                 setState(() {});
//                 showNameError = false;
//             } else {
//               setState(() {});
//               isLoading = true;
//               showNameError = false;
//               Set<int> usersId = Set<int>();
//               for(int i = 0; i < friendsProvider.selectedFriends.length; i++) {
//                 usersId.add(friendsProvider.selectedFriends[i].id);
//               }
//               usersId.add(AppUtils.userData.id);
//               print(AppUtils.userData.token);
//               var id = await chatBloc.intiateNewChat(
//                 IntiateNewChatRequest(
//                   users: usersId.toList(),
//                   title: nameController.text,
//                   creatorId: AppUtils.userData.id,
//                 ),
//               );
//
//               friendsProvider.selectedFriends.clear();
//
//               setState(() {});
//               isLoading = false;
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                   builder: (_) => PrivateChatPage(
//                     name: nameController.text,
//                     id: id,
//                   ),
//                 ),
//               );
//             }
//           },
//           height: 45,
//         ),
//       ),
//       body: StreamBuilder<FriendsListResponse>(
//         stream: socialBloc.showFriendsList.stream,
//         builder: (context, snapshot) {
//           if (socialBloc.loading.value) {
//             return Loader();
//           } else {
//             return SingleChildScrollView(
//               physics: bouncingScrollPhysics,
//               child: Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Group Chat Name',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       child: TextFormField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           errorText: showNameError ? AppUtils.translate(context, 'required') : '',
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: ScreenUtil().setWidth(12),
//                             vertical: ScreenUtil().setHeight(10),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: mainColor, width: 1),
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xffEEEEEE),
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(40),
//                     ),
//                     Text(
//                       'Add Members',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       height: friendsProvider.selectedFriends.isEmpty
//                           ? 0
//                           : ScreenUtil().setHeight(130),
//                       width: double.infinity,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         physics: bouncingScrollPhysics,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             margin: EdgeInsets.all(5),
//                             width: ScreenUtil().setWidth(110),
//                             child: Column(
//                               children: [
//                                 Stack(
//                                   overflow: Overflow.visible,
//                                   children: [
//                                     CircleAvatar(
//                                       radius: 28,
//                                       backgroundImage: AssetImage(
//                                         'assets/images/avatar.png',
//                                       ),
//                                     ),
//                                     Positioned(
//                                       right: -12,
//                                       top: -20,
//                                       child: IconButton(
//                                         icon: Icon(
//                                           Icons.cancel,
//                                           color: Colors.grey,
//                                         ),
//                                         onPressed: () {
//                                           friendsProvider.removeFriend(index);
//                                           setState(() {});
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   friendsProvider
//                                       .selectedFriends[index].username,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         itemCount: friendsProvider.selectedFriends.length,
//                       ),
//                     ),
//                     Container(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                                 BorderSide(color: mainColor, width: 1),
//                           ),
//                           hintText: 'Type the name of your friends',
//                           hintStyle: TextStyle(color: Colors.grey),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.grey,
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             horizontal: ScreenUtil().setWidth(12),
//                             vertical: ScreenUtil().setHeight(10),
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Color(0xffEEEEEE),
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(20),
//                     ),
//                     Text(
//                       'Friends',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(8),
//                     ),
//                     ListView.builder(
//                       itemCount: snapshot.data.data.length,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return FriendListTile(
//                           friend: snapshot.data.data[index],
//                           index: index,
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
// class FriendListTile extends StatefulWidget {
//   final int index;
//   final UserSocial friend;
//
//   const FriendListTile({
//     Key key,
//     @required this.index,
//     this.friend,
//   }) : super(key: key);
//
//   @override
//   _FriendListTileState createState() => _FriendListTileState();
// }
//
// class _FriendListTileState extends State<FriendListTile> {
//   @override
//   Widget build(BuildContext context) {
//     var friendsProvider = Provider.of<FriendsProvider>(context);
//     return ListTile(
//       onTap: () {
//         if (friendsProvider.selectedFriends.contains(widget.friend)) {
//           friendsProvider.removeFriend(widget.index);
//         } else {
//           friendsProvider.addFriend(widget.friend);
//         }
//       },
//       title: Text(
//         widget.friend.username,
//         style: TextStyle(fontWeight: FontWeight.w600),
//       ),
//       leading: CircleAvatar(
//         backgroundImage: widget.friend.image_url == null
//             ? AssetImage('assets/images/avatar.png')
//             : CachedNetworkImageProvider(widget.friend.image_url),
//       ),
//       trailing: Checkbox(
//         value: friendsProvider.selectedFriends.contains(widget.friend),
//         activeColor: mainColor,
//         onChanged: (bool selected) {
//           if (selected) {
//             friendsProvider.addFriend(widget.friend);
//           } else {
//             friendsProvider.removeFriend(widget.index);
//           }
//         },
//       ),
//     );
//   }
// }
