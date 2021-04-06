// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_absolute_path/flutter_absolute_path.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:phinex/Bles/bloc/social/RoomBloc.dart';
// import 'package:phinex/ui/widgets/my_app_bar.dart';
// import 'package:phinex/ui/widgets/my_button.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
//
// class CreateRoomPage extends StatefulWidget {
//   @override
//   _CreateRoomPageState createState() => _CreateRoomPageState();
// }
//
// class _CreateRoomPageState extends State<CreateRoomPage> {
//
//   TextEditingController nameController = TextEditingController();
//   File imageFile;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         resizeToAvoidBottomPadding: false,
//         appBar: myAppBar(
//           translate(context, 'create_room'),
//           context,
//           onBackBtnClicked: () {
//             Navigator.pop(context);
//           },
//         ),
//         bottomNavigationBar: Card(
//           margin: EdgeInsets.zero,
//           elevation: 5,
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(14),
//             child: myButton(
//               translate(context, 'create_room'),
//               height: ScreenUtil().setHeight(55),
//               btnColor:
//                   nameController.text.trim().isEmpty || imageFile == null ? Colors.grey : mainColor,
//               onTap: nameController.text.isEmpty
//                   ? null
//                   : () async {
//                       if (nameController.text.trim().isEmpty || imageFile == null) {
//                         return;
//                       }
//                       isLoading = true;
//                       setState(() {});
//                       await roomBloc.createRoom(
//                         AppUtils.userData.id,
//                         nameController.text,
//                         imageFile: imageFile,
//                       );
//                       nameController.text = '';
//                       isLoading = false;
//                       imageFile = null;
//                       setState(() {});
//                       AppUtils.showToast(
//                         msg: translate(context, 'group_created_successfully'),
//                         bgColor: mainColor,
//                       );
//                     },
//             ),
//           ),
//         ),
//         body: LoadingOverlay(
//           isLoading: isLoading,
//           progressIndicator: Loader(),
//           color: Colors.white,
//           opacity: .5,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   translate(context, 'room_name'),
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   child: TextFormField(
//                     controller: nameController,
//                     onChanged: (String input) {
//                       setState(() {});
//                     },
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                         horizontal: ScreenUtil().setWidth(12),
//                         vertical: ScreenUtil().setHeight(10),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: mainColor, width: 1),
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Color(0xffEEEEEE),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Text(AppUtils.translate(context, 'room_image')),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     getImage();
//                   },
//                   child: Center(
//                     child: CircleAvatar(
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.add_circle,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                         onPressed: () async {
//                           getImage();
//                         },
//                       ),
//                       radius: 65,
//                       backgroundImage:
//                           imageFile == null ? null : FileImage(imageFile),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
//   void getImage() async {
//     var granted = await AppUtils.askPhotosPermission();
//     if (granted) {
//       var images = await AppUtils.getImage(1);
//       if (images != null) {
//         var path = await FlutterAbsolutePath.getAbsolutePath(
//           images[0].identifier,
//         );
//
//         imageFile = File(path);
//         setState(() {});
//       }
//     } else {
//       AppUtils.showToast(msg: 'Accept Permission First');
//     }
//   }
// }