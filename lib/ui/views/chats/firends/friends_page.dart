// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:phinex/Bles/Model/responses/chat/FriendsCount.dart';
// import 'package:phinex/Bles/bloc/social/ChatBloc.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
// import 'friends_request_page.dart';
// import 'my_friends_list_page.dart';
//
// class FriendsPage extends StatefulWidget {
//   @override
//   _FriendsPageState createState() => _FriendsPageState();
// }
//
// class _FriendsPageState extends State<FriendsPage> {
//   @override
//   void initState() {
//     super.initState();
//
//     chatBloc.getFriendsCount(
//       AppUtils.userData.id,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<FriendsCountResponse>(
//       stream: chatBloc.friendsCount.stream,
//       builder: (context, snapshot) {
//         if (chatBloc.loading.value) {
//           return Loader();
//         } else {
//           return Column(
//             children: [
//               ListTile(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => MyFriendsListPage(),
//                     ),
//                   );
//                 },
//                 title: Text(
//                   'Friends',
//                 ),
//                 leading: Icon(
//                   FontAwesomeIcons.users,
//                   color: deepBlueColor,
//                 ),
//                 trailing: Container(
//                   width: MediaQuery.of(context).size.width / 3,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${snapshot.data.data.friends.toString()} ${snapshot.data.data.friends == 1 ? '${translate(context, 'friend')}' : '${translate(context, 'friends')}'}',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         size: 15,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => FriendsRequestPage(),
//                     ),
//                   );
//                 },
//                 title: Container(
//                   child: Row(
//                     children: [
//                       Text(
//                         translate(context, 'friend_requests'),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Text(
//                             snapshot.data.data.friendsRequests.toString(),
//                             style: TextStyle(fontSize: 10, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   width: MediaQuery.of(context).size.width / 2,
//                 ),
//                 trailing: Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 15,
//                 ),
//                 leading: Icon(
//                   Icons.person_add,
//                   color: deepBlueColor,
//                 ),
//               ),
//               // ListTile(
//               //   onTap: () {
//               //     Navigator.of(context).push(
//               //       MaterialPageRoute(
//               //         builder: (_) => BlockListPage(),
//               //       ),
//               //     );
//               //   },
//               //   title: Text(
//               //     'Block List',
//               //   ),
//               //   leading: Icon(
//               //     Icons.block,
//               //     color: Colors.red,
//               //   ),
//               //   trailing: Icon(
//               //     Icons.arrow_forward_ios_rounded,
//               //     size: 15,
//               //   ),
//               // ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
