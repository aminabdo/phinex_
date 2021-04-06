// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionLandingResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionsByCatResponse.dart';
// import 'package:phinex/Bles/bloc/auction/AuctionBloc.dart';
// import 'package:phinex/ui/widgets/my_app_bar.dart';
// import 'package:phinex/ui/widgets/my_button.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
// import 'package:phinex/utils/app_localization.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
//
// import 'auction_owner_view_page.dart';
// import 'auction_user_view_page.dart';
//
// class AuctionsCategoryPage extends StatefulWidget {
//   static final int pageIndex = 0;
//   final int id;
//   final String name;
//
//   const AuctionsCategoryPage({Key key, @required this.id, this.name})
//       : super(key: key);
//
//   @override
//   _AuctionsCategoryPageState createState() => _AuctionsCategoryPageState();
// }
//
// class _AuctionsCategoryPageState extends State<AuctionsCategoryPage> {
//   ScrollController _scrollController = ScrollController();
//   int skip = 0;
//   int take = 10;
//
//   @override
//   void initState() {
//     super.initState();
//
//     print(AppUtils.userData.token);
//
//     auctionBloc.getAuctionByCat(
//         BaseRequestSkipTake(take: take, skip: skip, id: widget.id));
//
//     pusher();
//   }
//
//   pusher() async {
//     await auctionBloc.initPusher();
//     await auctionBloc.connect();
//     await auctionBloc.subscribeCat();
//     await auctionBloc.bindCat();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBackgroundColor,
//       appBar: myAppBar(
//         widget.name,
//         context,
//       ),
//       body: StreamBuilder<AuctionsByCatResponse>(
//         stream: auctionBloc.auctionByCat.stream,
//         builder: (context, snapshot) {
//           if (auctionBloc.loading.value) {
//             return Loader();
//           } else {
//             _scrollController
//               ..addListener(
//                 () {
//                   if (_scrollController.position.pixels ==
//                       _scrollController.position.maxScrollExtent) {
//                     skip += 10;
//                     take = 10;
//                     auctionBloc.getAuctionByCat(
//                       BaseRequestSkipTake(
//                         take: take,
//                         skip: skip,
//                         id: widget.id,
//                       ),
//                     );
//                   }
//                 },
//               );
//
//             return SingleChildScrollView(
//               controller: _scrollController,
//               physics: bouncingScrollPhysics,
//               child: Padding(
//                 padding: EdgeInsets.all(
//                   ScreenUtil().setWidth(14),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       AppLocalization.of(context)
//                           .translate('popular_categories'),
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height: ScreenUtil().setHeight(10),
//                     ),
//                     GridView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate:
//                           MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
//                         height: ScreenUtil().setHeight(340),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 5,
//                         mainAxisSpacing: 5,
//                       ),
//                       itemCount: snapshot.data.data.length,
//                       itemBuilder: (context, index) {
//                         return AuctionCategoryItem(
//                           currentAuction: snapshot.data.data[index],
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
// class AuctionCategoryItem extends StatefulWidget {
//   final Auction currentAuction;
//
//   const AuctionCategoryItem({Key key, this.currentAuction}) : super(key: key);
//
//   @override
//   _AuctionCategoryItemState createState() => _AuctionCategoryItemState();
// }
//
// class _AuctionCategoryItemState extends State<AuctionCategoryItem> {
//   bool auctionFinished = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     calcDate(widget.currentAuction.endsAt);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (widget.currentAuction.sellerId == AppUtils.userData.id) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (_) => AuctionOwnerViewPage(
//                 name: widget.currentAuction.title,
//                 id: widget.currentAuction.id,
//               ),
//             ),
//           );
//         } else {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (_) => AuctionUserViewPage(
//                 name: widget.currentAuction.title,
//                 id: widget.currentAuction.id,
//               ),
//             ),
//           );
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.all(
//           ScreenUtil().setWidth(3),
//         ),
//         child: Material(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(12),
//             topRight: Radius.circular(12),
//             bottomLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//           elevation: 4,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                       ),
//                       child: CachedNetworkImage(
//                         imageUrl: widget.currentAuction.imageUrl,
//                         placeholder: (_, __) {
//                           return Loader(
//                             size: 40,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.currentAuction.title,
//                       style: TextStyle(color: deepBlueColor, fontSize: 16),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           AppUtils.translate(
//                             context,
//                             'open_price',
//                           ),
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           widget.currentAuction.openPrice.toString() + ' ${AppUtils.currency}',
//                           style: TextStyle(color: mainColor, fontSize: 10),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           color: Colors.red[100],
//                           child: Text(
//                             '${widget.currentAuction.totalPaids} ${AppUtils.translate(context, 'bid')}',
//                             style: TextStyle(
//                               color: Colors.red[800],
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 12,
//                         ),
//                         Text(
//                           auctionFinished
//                               ? AppUtils.translate(context, 'auction_ended')
//                               : (DateTime.parse(widget.currentAuction.endsAt)
//                                       .day
//                                       .toString() +
//                                   '  ' +
//                                   AppUtils.translate(context, 'day') +
//                                   ' ' +
//                                   AppUtils.translate(context, 'left')),
//                           style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               myButton(
//                 AppUtils.translate(context, 'see_details'),
//                 decoration: BoxDecoration(
//                   color: mainColor,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(12),
//                     bottomRight: Radius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   String calcDate(String endAt) {
//     DateTime dateEnd = DateTime.parse(endAt);
//     DateTime timeNow = DateTime.now();
//     if (dateEnd.isAfter(timeNow)) {
//       auctionFinished = true;
//       final difference = timeNow.difference(dateEnd);
//       return difference.inDays.abs().toStringAsFixed(0);
//     } else {
//       auctionFinished = false;
//       final difference = dateEnd.difference(timeNow);
//       return difference.inDays.abs().toStringAsFixed(0);
//     }
//   }
// }
