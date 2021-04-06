

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/coming_soon.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/app_localization.dart';

class NotificationPage extends StatefulWidget {
  static final int pageIndex = 3;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool withNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('notifications'),
        context,
        withLeading: false,
      ),
      body: WillPopScope(
        child: ComingSoon(),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());
          return false;
        },
      ),
      // Container(
      //   padding: EdgeInsets.only(
      //     left: ScreenUtil().setWidth(8),
      //     right: ScreenUtil().setWidth(8),
      //     top: ScreenUtil().setWidth(8),
      //     // bottom: ScreenUtil().setWidth(25),
      //   ),
      //   width: double.infinity,
      //   child: withNotifications
      //       ? SingleChildScrollView(
      //           physics: bouncingScrollPhysics,
      //           child: Column(
      //             children: [
      //               ListView.separated(
      //                 physics: NeverScrollableScrollPhysics(),
      //                 shrinkWrap: true,
      //                 itemBuilder: (context, index) {
      //                   return Container(
      //                     width: double.infinity,
      //                     child: Stack(
      //                       overflow: Overflow.visible,
      //                       children: [
      //                         Card(
      //                           elevation: 5,
      //                           color: Colors.white,
      //                           child: Padding(
      //                             padding: EdgeInsets.all(4.0),
      //                             child: Row(
      //                               crossAxisAlignment:
      //                                   CrossAxisAlignment.start,
      //                               children: [
      //                                 Container(
      //                                   width: ScreenUtil().setWidth(80),
      //                                   height: ScreenUtil().setHeight(80),
      //                                   decoration: BoxDecoration(
      //                                     color: Color(0xffF2F2F2),
      //                                     borderRadius:
      //                                         BorderRadius.circular(6),
      //                                   ),
      //                                   child: Icon(Icons.notifications),
      //                                 ),
      //                                 SizedBox(
      //                                   width: ScreenUtil().setWidth(10),
      //                                 ),
      //                                 Expanded(
      //                                   child: Padding(
      //                                     padding: EdgeInsets.symmetric(
      //                                       vertical:
      //                                           ScreenUtil().setHeight(12),
      //                                     ),
      //                                     child: Column(
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment
      //                                                   .spaceBetween,
      //                                           children: [
      //                                             Text(
      //                                               'Title',
      //                                               style: TextStyle(
      //                                                   color: Colors.black,
      //                                                   fontWeight:
      //                                                       FontWeight.bold,
      //                                                   fontSize: 16),
      //                                             ),
      //                                             Text(
      //                                               'Time',
      //                                               style: TextStyle(
      //                                                 color: Colors.grey,
      //                                                 fontSize: 13,
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                         SizedBox(
      //                                           height:
      //                                               ScreenUtil().setHeight(3),
      //                                         ),
      //                                         Text(
      //                                           'Description',
      //                                           style: TextStyle(
      //                                             color: Colors.black38,
      //                                             fontSize: 14,
      //                                           ),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         Positioned(
      //                           bottom: -10,
      //                           left: Localizations.localeOf(context).languageCode == 'en' ? ScreenUtil().setWidth(-170) : null,
      //                           right: Localizations.localeOf(context).languageCode == 'ar' ? ScreenUtil().setWidth(70) : 0,
      //                           child: Container(
      //                             width: ScreenUtil().setWidth(30),
      //                             height: ScreenUtil().setHeight(30),
      //                             decoration: BoxDecoration(
      //                               shape: BoxShape.circle,
      //                               color: Colors.white,
      //                               boxShadow: [
      //                                 BoxShadow(
      //                                   color: Colors.grey,
      //                                   offset: Offset(0, 0),
      //                                   blurRadius: 1,
      //                                 ),
      //                               ],
      //                             ),
      //                             child: Center(
      //                               child: Container(
      //                                 width: ScreenUtil().setWidth(20),
      //                                 height: ScreenUtil().setHeight(20),
      //                                 decoration: BoxDecoration(
      //                                   shape: BoxShape.circle,
      //                                   color: Colors.yellow,
      //                                 ),
      //                                 child: Center(
      //                                   child: Icon(
      //                                     FontAwesomeIcons.info,
      //                                     size: 10,
      //                                     color: Colors.white,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   );
      //                 },
      //                 itemCount: 6,
      //                 separatorBuilder: (BuildContext context, int index) {
      //                   return SizedBox(
      //                     height: ScreenUtil().setHeight(16),
      //                   );
      //                 },
      //               ),
      //               SizedBox(
      //                 height: ScreenUtil().setHeight(18),
      //               ),
      //             ],
      //           ),
      //         )
      //       : Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.notifications,
      //               size: 250,
      //               color: Color(0xff9895B3),
      //             ),
      //             GestureDetector(
      //               onTap: () {},
      //               child: Text(
      //                 AppLocalization.of(context)
      //                     .translate('no_notifications_msg'),
      //                 style: TextStyle(fontSize: 22, color: Colors.black45),
      //                 textAlign: TextAlign.center,
      //               ),
      //             )
      //           ],
      //         ),
      // ),
    );
  }
}
