// import 'dart:convert';
// import 'package:dio/dio.dart';
//
// import 'package:rxdart/rxdart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
// import 'package:phinex/Bles/Model/requests/auctions/MakeDealRequest.dart';
// import 'package:phinex/Bles/Model/requests/auctions/SubmitBidRequest.dart';
// import 'package:phinex/Bles/Model/requests/auctions/SubmitDealReplyRequest.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionBidResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionDealsResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionIODealReplyResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionIOSubmitBidResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionIOSubmitMakeDealResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionLandingResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionSingleResponse.dart';
// import 'package:phinex/Bles/Model/responses/auctions/AuctionsByCatResponse.dart';
// import 'package:phinex/utils/app_utils.dart';
// import 'package:phinex/utils/base/BaseBloc.dart';
// import 'package:phinex/utils/base/BaseRequest.dart';
//
// import '../../ApiRoutes.dart';
//
// class HighestPriceBloc extends BaseBloc {
//   BehaviorSubject<AuctionLandingResponse> _landing =
//   BehaviorSubject<AuctionLandingResponse>();
//   BehaviorSubject<AuctionsByCatResponse> _auctionByCat =
//   BehaviorSubject<AuctionsByCatResponse>();
//   BehaviorSubject<AuctionSingleResponse> _auctionSingle =
//   BehaviorSubject<AuctionSingleResponse>();
//   BehaviorSubject<AuctionBidResponse> _auctionBids =
//   BehaviorSubject<AuctionBidResponse>();
//   BehaviorSubject<AuctionDealsResponse> _auctionDeals =
//   BehaviorSubject<AuctionDealsResponse>();
//   BehaviorSubject<bool> subLoading = BehaviorSubject<bool>();
//
//   HighestPriceBloc() {
//     initPusher();
//   }
//
//   getLanding() async {
//     loading.value = true;
//     _landing.value = AuctionLandingResponse.fromMap(
//         (await repository.get(ApiRoutes.wholesaleLanding)).data);
//     loading.value = false;
//   }
//
//   getAuctionByCat(BaseRequestSkipTake request) async {
//     loading.value = true;
//     if (request.skip == 0)
//       _auctionByCat.value = AuctionsByCatResponse.fromMap(
//           (await repository.get(ApiRoutes.showWholesaleByCat(request))).data);
//     else
//       _auctionByCat.value.data.addAll(AuctionsByCatResponse.fromMap(
//           (await repository.get(ApiRoutes.showWholesaleByCat(request))).data)
//           .data);
//
//     _auctionByCat.value = _auctionByCat.value;
//     loading.value = false;
//   }
//
//   getAuctionSingle(BaseRequestSkipTake request) async {
//     loading.value = true;
//     _auctionSingle.value = AuctionSingleResponse.fromMap(
//         (await repository.get(ApiRoutes.showWholesaleSingle(request))).data);
//     loading.value = false;
//   }
//
//   getAuctionBids(BaseRequestSkipTake request) async {
//     subLoading.value = true;
//     _auctionBids.value = AuctionBidResponse.fromMap(
//         (await repository.get(ApiRoutes.showWholesaleBids(request))).data);
//
//     _auctionSingle.value.data.auctionee
//         .addAll(_auctionBids.value.data.auctionee);
//
//     subLoading.value = false;
//   }
//
//   getAuctionDeals(BaseRequestSkipTake request) async {
//     subLoading.value = true;
//     _auctionDeals.value = AuctionDealsResponse.fromMap(
//         (await repository.get(ApiRoutes.showWholesaleDeals(request))).data);
//
//     if (auctionSingle.value == null) {}
//     if (request.skip == 0) {
//       _auctionSingle.value.data.makeDeal = _auctionDeals.value.data.makeDeal;
//     } else {
//       _auctionSingle.value.data.makeDeal
//           .addAll(_auctionDeals.value.data.makeDeal);
//     }
//
//     _auctionDeals.value = _auctionDeals.value;
//     subLoading.value = false;
//   }
//
//   makeDeal(MakeDealRequest request) async {
//     response.value = await repository.post(
//         ApiRoutes.makeWholesaledeal(request.auctionId), request.toJson());
//   }
//
//   submitBid(SubmitBidRequest request) async {
//     response.value = await repository.post(
//         ApiRoutes.submitWholesaleBid(request.auctionId), request.toJson());
//   }
//
//   submitDealReply(SubmitDealReplyRequest request) async {
//     response.value = await repository.post(
//         ApiRoutes.submitWholesaleDealReply(request.auctionId), request.toJson());
//   }
//
//   Future<Response> createWholesale(BaseRequest request) async {
//     response.value = await repository.post(ApiRoutes.createWholesale, request.toJson());
//     return response.value;
//   }
//
//   @override
//   dispose() {
//     super.dispose();
//     _landing.close();
//     _auctionByCat.close();
//     _auctionSingle.close();
//   }
//
//   @override
//   clear() {
//     super.clear();
//     _landing = BehaviorSubject<AuctionLandingResponse>();
//     _auctionByCat = BehaviorSubject<AuctionsByCatResponse>();
//     _auctionSingle = BehaviorSubject<AuctionSingleResponse>();
//   }
//
//   BehaviorSubject<AuctionLandingResponse> get landing => _landing;
//
//   BehaviorSubject<AuctionsByCatResponse> get auctionByCat => _auctionByCat;
//
//   BehaviorSubject<AuctionSingleResponse> get auctionSingle => _auctionSingle;
//
//   Event lastEvent;
//   String lastConnectionState;
//   Channel singleChannelName, catChannelName;
//   String appKey = "CD123456";
//   String channelCat = "presence-auctions";
//   String channelSingle = "presence-auction.";
//
//   String bidCreatedEvent = "App\\Events\\BidCreated";
//   String dealAcceptedEvent = "App\\Events\\DealAccepted";
//   String dealOfferedEvent = "App\\Events\\DealOffered";
//
//   String authLink = "https://developers.api.phinex.net/v-1872020/eg-en/auction/broadcasting/auth";
//
//   //String cluster = "eu";
//   String host = "synchronizer.phinex.net";
//   int port = 6001;
//   bool encrypted = false;
//   bool logging = true;
//
//   Future<void> initPusher() async {
//     try {
//       await Pusher.init(
//           appKey,
//           PusherOptions(
//             auth: PusherAuth(authLink, headers: {
//               'content-type': 'application/x-www-form-urlencoded',
//               'Authorization': AppUtils.userData?.id.toString() ?? ''
//             }),
//             //cluster: cluster,
//             host: host,
//             port: port,
//             encrypted: encrypted,
//           ),
//           enableLogging: logging,
//       );
//
//       await connect();
//     } on PlatformException catch (e) {
//       print("platform exeption ------------------->   ");
//       print(e.message);
//     }
//   }
//
//   connect() {
//     Pusher.connect(onConnectionStateChange: (x) async {
//       lastConnectionState = x.currentState;
//       debugPrint("in connection --->> >> ");
//     }, onError: (x) {
//       debugPrint("Error in connection --->> >> : ${x.message}");
//     });
//   }
//
//   disconnect() {
//     Pusher.disconnect();
//   }
//
//   subscribeCat() async {
//     debugPrint("subscribe --->> >> ");
//     catChannelName = await Pusher.subscribe(channelCat);
//   }
//
//   subscribeSingle(int auctionID) async {
//     debugPrint("subscribe --->> >> ");
//     singleChannelName =
//     await Pusher.subscribe(channelSingle + auctionID.toString());
//   }
//
//   bindSingle() async {
//     singleChannelName.bind(this.bidCreatedEvent, (x) {
//       lastEvent = x;
//       debugPrint("bidCreatedEvent ------->>>>>>>");
//       debugPrint(x.data);
//       AuctionIOSubmitBidResponse auctionIOSubmitBidResponse =
//       AuctionIOSubmitBidResponse.fromMap(json.decode(lastEvent.data));
//       auctionSingle.value.data.auctionee
//           .add(auctionIOSubmitBidResponse.auctionee);
//       auctionSingle.value = auctionSingle.value;
//     });
//     singleChannelName.bind(this.dealAcceptedEvent, (x) {
//       lastEvent = x;
//       debugPrint("dealAcceptedEvent ------->>>>>>>");
//       debugPrint(x.data);
//       AuctionIODealReplyResponse auctionIODealReplyResponse =
//       AuctionIODealReplyResponse.fromMap(json.decode(lastEvent.data));
//       print("da --> " + lastEvent.data);
//       auctionSingle.value.data.status =
//       'closed'; //auctionIODealReplyResponse.data.status ;
//       auctionSingle.value = auctionSingle.value;
//     });
//     singleChannelName.bind(this.dealOfferedEvent, (x) {
//       lastEvent = x;
//       debugPrint("dealOfferedEvent ------->>>>>>>");
//       debugPrint(x.data);
//       AuctionIOSubmitMakeDealResponse auctionIOSubmitMakeDealResponse =
//       AuctionIOSubmitMakeDealResponse.fromMap(json.decode(lastEvent.data));
//       auctionSingle.value.data.makeDeal
//           .add(auctionIOSubmitMakeDealResponse.makeDeal);
//       auctionSingle.value = auctionSingle.value;
//     });
//   }
//
//   bindCat() async {
//     catChannelName.bind(this.bidCreatedEvent, (x) {
//       lastEvent = x;
//       debugPrint("bidCreatedEvent ------->>>>>>>");
//       debugPrint(x.data);
//       AuctionIOSubmitBidResponse auctionIOSubmitBidResponse = AuctionIOSubmitBidResponse.fromMap(json.decode(lastEvent.data));
//
//     });
//     catChannelName.bind(this.dealAcceptedEvent, (x) {
//       lastEvent = x;
//       debugPrint("dealAcceptedEvent ------->>>>>>>");
//       debugPrint(x.data);
//       AuctionIODealReplyResponse auctionIODealReplyResponse = AuctionIODealReplyResponse.fromMap(json.decode(lastEvent.data));
//     });
//   }
//
//   unbindSingle() async {
//     await singleChannelName.unbind(this.bidCreatedEvent);
//     await singleChannelName.unbind(this.dealAcceptedEvent);
//     await singleChannelName.unbind(this.dealOfferedEvent);
//   }
//
//   unbind2() async {
//     await catChannelName.unbind(this.bidCreatedEvent);
//     await catChannelName.unbind(this.dealAcceptedEvent);
//   }
//
//   unsubscribeSingle(int auctionID) async {
//     await Pusher.unsubscribe(channelSingle + auctionID.toString());
//   }
//
//   unsubscribeCat() async {
//     await Pusher.unsubscribe(channelCat);
//   }
// }
//
// var highestPriceBloc = HighestPriceBloc();
