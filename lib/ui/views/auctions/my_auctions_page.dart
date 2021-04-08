// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:phinex/Bles/Model/responses/auctions/MyAuctionsResponse.dart';
// import 'package:phinex/Bles/bloc/auction/VipBloc.dart';
// import 'package:phinex/providers/page_provider.dart';
// import 'package:phinex/ui/views/more/more_page.dart';
// import 'package:phinex/ui/widgets/my_app_bar.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/utils/app_localization.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:time_ago_provider/time_ago_provider.dart' as timeAgo;
// import 'package:phinex/utils/consts.dart';
//
// class MyAuctionsPage extends StatefulWidget {
//   static final int pageIndex = 4;
//
//   @override
//   _MyAuctionsPageState createState() => _MyAuctionsPageState();
// }
//
// class _MyAuctionsPageState extends State<MyAuctionsPage> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     vipBloc.geMyAuctions(AppUtils.userData.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(
//         AppLocalization.of(context).translate('my_auctions'),
//         context,
//         onBackBtnClicked: () {
//           Provider.of<PageProvider>(context, listen: false)
//               .setPage(MorePage.pageIndex, MorePage());
//         },
//       ),
//       body: StreamBuilder<MyAuctionsResponse>(
//           stream: vipBloc.myAuctions.stream,
//           builder: (context, snapshot) {
//             if(vipBloc.loading.value) {
//               return Loader();
//             } else {
//               return WillPopScope(
//                 child:
//                 ListView.separated(
//                   separatorBuilder: (BuildContext context, int index) {
//                     return Divider(
//                       thickness: 1,
//                       color: Colors.grey[350],
//                     );
//                   },
//                   physics: bouncingScrollPhysics,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       padding: EdgeInsets.all(
//                         ScreenUtil().setWidth(10),
//                       ),
//                       width: double.infinity,
//                       color: Colors.white,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         AppLocalization.of(context).translate('auction'),
//                                         textAlign: Localizations.localeOf(context)
//                                             .languageCode ==
//                                             'ar'
//                                             ? TextAlign.right
//                                             : TextAlign.left,
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         AppLocalization.of(context).translate('end_date'),
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         AppLocalization.of(context)
//                                             .translate('open_price'),
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         AppLocalization.of(context).translate('total'),
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: ScreenUtil().setWidth(15),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         snapshot.data.data[index].title,
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         timeAgo.format(DateTime.parse(snapshot.data.data[index].createdAt)),
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         '${snapshot.data.data[index].openPrice} ${AppUtils.currency}',
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       Text(
//                                         '${snapshot.data.data[index].totalPaids} ${AppUtils.currency}',
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: ScreenUtil().setWidth(15),
//                               ),
//                               // Expanded(
//                               //   flex: 3,
//                               //   child: Container(
//                               //     child: Center(
//                               //       child: Container(
//                               //         width: double.infinity,
//                               //         height: ScreenUtil().setHeight(120),
//                               //         decoration: BoxDecoration(
//                               //           borderRadius: BorderRadius.circular(12),
//                               //           color: greenColor.withOpacity(.3),
//                               //         ),
//                               //         child: Column(
//                               //           mainAxisAlignment: MainAxisAlignment.center,
//                               //           children: [
//                               //             Text(
//                               //               '${AppLocalization.of(context).translate('you_pay')} & ${AppLocalization.of(context).translate('date')}',
//                               //               style: TextStyle(
//                               //                 color: deepBlueColor,
//                               //                 fontWeight: FontWeight.bold,
//                               //                 fontSize: 13,
//                               //               ),
//                               //             ),
//                               //             SizedBox(
//                               //               height: ScreenUtil().setHeight(5),
//                               //             ),
//                               //             Text(
//                               //               '\$55.000.000',
//                               //               style: TextStyle(
//                               //                 color: greenColor,
//                               //                 fontWeight: FontWeight.bold,
//                               //                 fontSize: 15,
//                               //               ),
//                               //             ),
//                               //             SizedBox(
//                               //               height: ScreenUtil().setHeight(5),
//                               //             ),
//                               //             Text(
//                               //               'Apr 4, 2020 - 23:00 PM',
//                               //               style: TextStyle(
//                               //                 color: greenColor.withOpacity(.5),
//                               //                 fontWeight: FontWeight.bold,
//                               //                 fontSize: 12,
//                               //               ),
//                               //             ),
//                               //           ],
//                               //         ),
//                               //       ),
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: snapshot.data.data.length,
//                 ),
//                 onWillPop: () async {
//                   Provider.of<PageProvider>(context, listen: false)
//                       .setPage(MorePage.pageIndex, MorePage());
//                   return false;
//                 },
//               );
//             }
//           }
//       ),
//
//     );
//   }
// }
