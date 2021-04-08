// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/requests/auctions/MakeDealRequest.dart';
// import 'package:phinex/Bles/Model/requests/auctions/SubmitBidRequest.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionSingleResponse.dart';
// import 'package:phinex/Bles/bloc/auction/HighestPriceBloc.dart';
// import 'package:phinex/ui/widgets/my_app_bar.dart';
// import 'package:phinex/ui/widgets/my_button.dart';
// import 'package:phinex/ui/widgets/my_loader.dart';
// import 'package:phinex/ui/widgets/my_text_form_field.dart';
// import 'package:phinex/utils/app_localization.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/consts.dart';
//
// import 'lot_owner_view_page.dart';
//
// class LotUserViewPage extends StatefulWidget {
//   final int id;
//   final String name;
//
//   const LotUserViewPage({Key key, @required this.id, @required this.name})
//       : super(key: key);
//
//   @override
//   _LotUserViewPageState createState() => _LotUserViewPageState();
// }
//
// class _LotUserViewPageState extends State<LotUserViewPage> {
//   bool readMore = false;
//   int currentItem = 0;
//
//   String day = '';
//   String hour = '';
//   String min = '';
//   String sec = '';
//
//   ScrollController _scrollController = ScrollController();
//   TextEditingController textEditingController = TextEditingController();
//
//   int skip = 0;
//   int take = 10;
//
//   bool placeAnOffer = true;
//   bool makeAction = false;
//   bool auctionIsNotStarted = false;
//
//   String translate(BuildContext context, String key) {
//     return AppLocalization.of(context).translate(key);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     highestPriceBloc.getAuctionSingle(BaseRequestSkipTake(
//       id: widget.id,
//       skip: skip,
//       take: take,
//     ));
//
//     pusher();
//   }
//
//   pusher() async {
//     await highestPriceBloc.initPusher();
//     await highestPriceBloc.connect();
//     await highestPriceBloc.subscribeSingle(widget.id);
//     await highestPriceBloc.bindSingle();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppBar(
//         widget.name,
//         context,
//       ),
//       backgroundColor: scaffoldBackgroundColor,
//       body: StreamBuilder<AuctionSingleResponse>(
//         stream: highestPriceBloc.auctionSingle.stream,
//         builder: (context, snapshot) {
//           if (highestPriceBloc.loading.value) {
//             return Loader();
//           } else {
//             calcDate(snapshot.data.data.endsAt, snapshot.data.data.opensFrom);
//             _scrollController
//               ..addListener(
//                 () {
//                   if (_scrollController.position.pixels ==
//                       _scrollController.position.maxScrollExtent) {
//                     skip += 10;
//                     take = 10;
//                     highestPriceBloc.getAuctionBids(
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
//               physics: BouncingScrollPhysics(),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       CarouselSlider(
//                         items: snapshot.data.data.gallary
//                             .map(
//                               (imageUrl) => Padding(
//                                 padding: EdgeInsets.all(12.0),
//                                 child: Container(
//                                   child: imageUrl == null || imageUrl.isEmpty
//                                       ? Image.asset(
//                                           'assets/images/no-product-image.png',
//                                           // fit: BoxFit.fill,
//                                         )
//                                       : Padding(
//                                           padding: EdgeInsets.all(12.0),
//                                           child: CachedNetworkImage(
//                                             imageUrl: imageUrl,
//                                             placeholder: (context, url) {
//                                               return Loader(
//                                                 size: 60,
//                                               );
//                                             },
//                                             // fit: BoxFit.fill,
//                                             errorWidget: (_, __, ___) {
//                                               return Icon(Icons.error);
//                                             },
//                                           ),
//                                         ),
//                                   width: double.infinity,
//                                   height: ScreenUtil().setHeight(250),
//                                 ),
//                               ),
//                             )
//                             .toList(),
//                         options: CarouselOptions(
//                           height: ScreenUtil().setHeight(320),
//                           aspectRatio: 16 / 9,
//                           viewportFraction: 1,
//                           onPageChanged: (int index, _) {
//                             currentItem = index;
//                             setState(() {});
//                           },
//                           initialPage: 0,
//                           enableInfiniteScroll: true,
//                           reverse: false,
//                           autoPlay: true,
//                           autoPlayInterval: Duration(seconds: 3),
//                           autoPlayAnimationDuration:
//                               Duration(milliseconds: 1000),
//                           autoPlayCurve: Curves.fastOutSlowIn,
//                           enlargeCenterPage: true,
//                           scrollDirection: Axis.horizontal,
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 10,
//                         left: 10,
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                               snapshot.data.data.gallary.length,
//                               (index) => AnimatedContainer(
//                                 margin: EdgeInsets.only(right: 5),
//                                 duration: Duration(milliseconds: 600),
//                                 width: ScreenUtil().setWidth(10),
//                                 height: ScreenUtil().setHeight(10),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: currentItem == index
//                                       ? mainColor
//                                       : mainColor.withOpacity(.3),
//                                 ),
//                               ),
//                             ).toList(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: ScreenUtil().setHeight(8),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         child: Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppLocalization.of(context)
//                                       .translate('about_auction'),
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: ScreenUtil().setHeight(8),
//                                 ),
//                                 Text(
//                                   snapshot.data.data.description,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: readMore ? 30 : 1,
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: ScreenUtil().setHeight(14),
//                                 ),
//                                 snapshot.data.data.description.length > 70
//                                     ? GestureDetector(
//                                         child: Text(
//                                           readMore
//                                               ? AppLocalization.of(context)
//                                                   .translate('read_less')
//                                               : AppLocalization.of(context)
//                                                   .translate('read_more'),
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: deepBlueColor,
//                                           ),
//                                         ),
//                                         onTap: () {
//                                           readMore = !readMore;
//                                           setState(() {});
//                                         },
//                                       )
//                                     : SizedBox.shrink(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: ScreenUtil().setHeight(8),
//                       ),
//                       snapshot.data.data.status == 'close'
//                           ? Container(
//                               width: double.infinity,
//                               child: Card(
//                                 color: Colors.white,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         AppLocalization.of(context).translate(
//                                             'auction_has_been_ended'),
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.red,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: ScreenUtil().setHeight(10),
//                                       ),
//                                       Text(
//                                         AppLocalization.of(context)
//                                                 .translate('owned_by') +
//                                             ' ' +
//                                             snapshot.data.data.winedUser.user
//                                                 .firstName +
//                                             ' ' +
//                                             snapshot.data.data.winedUser.user
//                                                 .lastName,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: ScreenUtil().setHeight(10),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               width: double.infinity,
//                               child: Card(
//                                 color: Colors.white,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         AppLocalization.of(context)
//                                             .translate('auction_details'),
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: ScreenUtil().setHeight(10),
//                                       ),
//                                       Card(
//                                         color: deepBlueColor,
//                                         elevation: 5,
//                                         child: Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               SizedBox(
//                                                 height:
//                                                     ScreenUtil().setHeight(12),
//                                               ),
//                                               auctionIsNotStarted
//                                                   ? Text(
//                                                       'Time remaining to start auction',
//                                                       style: TextStyle(
//                                                           fontSize: 16,
//                                                           color: Colors.white),
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                     )
//                                                   : SizedBox.shrink(),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   DayCircle(text: day),
//                                                   DayCircle(text: hour),
//                                                   DayCircle(text: min),
//                                                   DayCircle(text: sec),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height:
//                                                     ScreenUtil().setHeight(8),
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Text(
//                                                     AppLocalization.of(context)
//                                                         .translate('day'),
//                                                     style: TextStyle(
//                                                       color: Colors.yellow,
//                                                       fontSize: 13,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     AppLocalization.of(context)
//                                                         .translate('hr'),
//                                                     style: TextStyle(
//                                                         color: Colors.yellow,
//                                                         fontSize: 13),
//                                                   ),
//                                                   Text(
//                                                     AppLocalization.of(context)
//                                                         .translate('min'),
//                                                     style: TextStyle(
//                                                         color: Colors.yellow,
//                                                         fontSize: 13),
//                                                   ),
//                                                   Text(
//                                                     AppLocalization.of(context)
//                                                         .translate('sec'),
//                                                     style: TextStyle(
//                                                       color: Colors.yellow,
//                                                       fontSize: 13,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     '${AppLocalization.of(context).translate('current_bid')}:   ',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: 18,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     snapshot.data.data.openPrice
//                                                             .toString() +
//                                                         ' ${AppUtils.currency}',
//                                                     style: TextStyle(
//                                                       color: Colors.white60,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 20,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Text(
//                                                 '${translate(context, 'increment_value_is')}: ${snapshot.data.data.incrementValue}',
//                                                 style: TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                       SizedBox(
//                         height: ScreenUtil().setHeight(8),
//                       ),
//                       auctionIsNotStarted
//                           ? SizedBox.shrink()
//                           : Container(
//                               width: double.infinity,
//                               child: Card(
//                                 elevation: 5,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: myButton(
//                                               AppLocalization.of(context)
//                                                   .translate('place_an_offer'),
//                                               btnColor: placeAnOffer
//                                                   ? deepBlueColor
//                                                   : Colors.grey,
//                                               onTap: () {
//                                                 placeAnOffer = true;
//                                                 setState(() {});
//                                               },
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: ScreenUtil().setWidth(8),
//                                           ),
//                                           Expanded(
//                                             child: myButton(
//                                                 AppLocalization.of(context)
//                                                     .translate('make_a_deal'),
//                                                 btnColor: !placeAnOffer
//                                                     ? deepBlueColor
//                                                     : Colors.grey, onTap: () {
//                                               placeAnOffer = false;
//                                               setState(() {});
//                                             }),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(
//                                         height: ScreenUtil().setHeight(12),
//                                       ),
//                                       Text(
//                                         translate(context, 'place_your_price'),
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                       MyTextFormField(
//                                         hintText: AppLocalization.of(context)
//                                             .translate('place_offer'),
//                                         controller: textEditingController,
//                                         keyboardType: TextInputType.number,
//                                       ),
//                                       SizedBox(
//                                         height: ScreenUtil().setHeight(16),
//                                       ),
//                                       makeAction
//                                           ? Loader(
//                                               size: 30,
//                                             )
//                                           : myButton(
//                                               AppLocalization.of(context)
//                                                   .translate('submit'),
//                                               btnColor: mainColor,
//                                               onTap: () async {
//                                                 if (textEditingController
//                                                     .text.isEmpty) {
//                                                   return;
//                                                 }
//                                                 if (placeAnOffer) {
//                                                   if (num.parse(
//                                                           textEditingController
//                                                               .text) >
//                                                       snapshot.data.data
//                                                           .openPrice) {
//                                                     if (num.parse(
//                                                             textEditingController
//                                                                 .text) >
//                                                         snapshot.data.data
//                                                             .incrementValue) {
//                                                       makeAction = true;
//                                                       setState(() {});
//                                                       await highestPriceBloc
//                                                           .submitBid(
//                                                         SubmitBidRequest(
//                                                           userId: AppUtils
//                                                               .userData.id,
//                                                           auctionId: widget.id,
//                                                           paidPrice: int.parse(
//                                                               textEditingController
//                                                                   .text),
//                                                         ),
//                                                       );
//                                                       AppUtils.showToast(
//                                                           msg: translate(
//                                                               context, 'done'),
//                                                           bgColor: mainColor);
//                                                       highestPriceBloc
//                                                               .auctionSingle
//                                                               .value
//                                                               .data
//                                                               .openPrice =
//                                                           int.parse(
//                                                               textEditingController
//                                                                   .text);
//                                                     } else {
//                                                       AppUtils.showToast(
//                                                           msg:
//                                                               '${translate(context, 'increment_value_is')} ${snapshot.data.data.openPrice}');
//                                                     }
//                                                   } else {
//                                                     AppUtils.showToast(
//                                                         msg:
//                                                             '${translate(context, 'min_price_is')} ${snapshot.data.data.openPrice}');
//                                                   }
//                                                 } else {
//                                                   if (num.parse(
//                                                           textEditingController
//                                                               .text) >
//                                                       snapshot.data.data
//                                                           .openPrice) {
//                                                     makeAction = true;
//                                                     setState(() {});
//                                                     await highestPriceBloc.makeDeal(
//                                                       MakeDealRequest(
//                                                         auctionId: widget.id,
//                                                         userId: AppUtils
//                                                             .userData.id,
//                                                         price: double.parse(
//                                                                 textEditingController
//                                                                     .text)
//                                                             .toInt(),
//                                                       ),
//                                                     );
//
//                                                     AppUtils.showToast(
//                                                         msg: translate(
//                                                             context, 'done'),
//                                                         bgColor: mainColor);
//                                                   } else {
//                                                     AppUtils.showToast(
//                                                         msg:
//                                                             '${translate(context, 'min_price_is')} ${snapshot.data.data.openPrice}');
//                                                   }
//                                                 }
//                                                 textEditingController.clear();
//                                                 makeAction = false;
//                                                 setState(() {});
//                                               },
//                                             ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                       SizedBox(
//                         height: ScreenUtil().setHeight(12),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         child: Card(
//                           elevation: 5,
//                           child: Padding(
//                             padding: EdgeInsets.all(12.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                         child: myButton(
//                                       AppLocalization.of(context)
//                                           .translate('auction'),
//                                     )),
//                                     SizedBox(
//                                       width: ScreenUtil().setWidth(8),
//                                     ),
//                                     Expanded(
//                                       child: myButton(
//                                         AppLocalization.of(context)
//                                             .translate('auction_log'),
//                                         btnColor: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: ScreenUtil().setHeight(18),
//                                 ),
//                                 ListView.separated(
//                                   itemBuilder: (context, index) {
//                                     return Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           snapshot.data.data.auctionee[index]
//                                               .user.username,
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           '${snapshot.data.data.auctionee[index].paidPrice} ${AppUtils.currency}',
//                                           style: TextStyle(
//                                             color: mainColor,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                   itemCount:
//                                       snapshot.data.data.auctionee.length,
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   separatorBuilder:
//                                       (BuildContext context, int index) {
//                                     return Divider(
//                                       thickness: .4,
//                                       color: Colors.grey,
//                                       height: ScreenUtil().setHeight(25),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: ScreenUtil().setHeight(12),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   void calcDate(String endAt, String startTime) {
//     // check if the start time is not began yet
//     // calculate how much to start
//     DateTime dateStart = DateTime.parse(startTime);
//     DateTime dateEnd = DateTime.parse(endAt);
//     DateTime timeNow = DateTime.now();
//     if (dateStart.isAfter(timeNow)) {
//       auctionIsNotStarted = true;
//       final difference = timeNow.difference(dateStart);
//       day = difference.inDays.abs().toStringAsFixed(0);
//       hour = difference.inHours.abs().toStringAsFixed(0);
//       min = difference.inMinutes.abs().toStringAsFixed(0);
//       sec = difference.inSeconds.abs().toStringAsFixed(0);
//     } else {
//       auctionIsNotStarted = false;
//       final difference = dateEnd.difference(timeNow);
//       day = difference.inDays.abs().toStringAsFixed(0);
//       hour = difference.inHours.abs().toStringAsFixed(0);
//       min = difference.inMinutes.abs().toStringAsFixed(0);
//       sec = difference.inSeconds.abs().toStringAsFixed(0);
//     }
//   }
// }
