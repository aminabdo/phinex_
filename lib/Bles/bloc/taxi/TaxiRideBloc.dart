// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:phinex/Bles/Model/responses/taxi_client/BaseRideResponse.dart';
// import 'package:phinex/Bles/Model/responses/taxi_client/General.dart';
// import 'package:phinex/ui/views/driver/driver_behavour_class.dart';
// import 'package:pusher_websocket_flutter/pusher.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:tbdm/Bles/Model/requests/taxi_client/ChangeRideStatusRequest.dart';
// import 'package:tbdm/Bles/Model/requests/taxi_client/MakeRideRequest.dart';
// import 'package:tbdm/Bles/Model/requests/taxi_client/UserRateRequest.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/BaseRideResponse.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/General.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/ShowRideReplyByRide.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/SingleRideReply.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/UserRidesResponse.dart';
// import 'package:tbdm/Bles/Model/responses/taxi_client/VehicleTypeResponse.dart';
// import 'package:tbdm/ui/views/driver/driver_behavour_class.dart';
// import 'package:tbdm/utils/base/BaseBloc.dart';
//
// import '../../ApiRoutes.dart';
//
// class TaxiRideBloc extends BaseBloc {
//   BehaviorSubject<VehicleTypeResponse> _vehickeTypes =
//       BehaviorSubject<VehicleTypeResponse>();
//   BehaviorSubject<BaseRideResponse> _ride = BehaviorSubject<BaseRideResponse>()..value = BaseRideResponse();
//   BehaviorSubject<UserRidesResponse> _rides =
//       BehaviorSubject<UserRidesResponse>();
//   BehaviorSubject<ShowRideReplyByRide> _rideReplies =
//       BehaviorSubject<ShowRideReplyByRide>();
//
//   TaxiRideBloc() {
//     initPusher();
//   }
//
//   getVehicleTypeResponse() async {
//     if (_vehickeTypes.value != null) return;
//     VehicleTypeResponse response = VehicleTypeResponse.fromMap(
//         (await repository.get2(ApiRoutes.getVehicleTypes())).data);
//     _vehickeTypes.value = response;
//   }
//
//   getUserRides(int userID) async {
//     loading.value = true;
//     UserRidesResponse response = UserRidesResponse.fromMap(
//         (await repository.get2(ApiRoutes.getUserRides(userID))).data);
//     _rides.value = response;
//     loading.value = false;
//   }
//
//   getReplyRides(int rideID) async {
//     loading.value = true;
//     ShowRideReplyByRide response = ShowRideReplyByRide.fromMap(
//         (await repository.get2(ApiRoutes.getReplyRides(rideID))).data);
//     _rideReplies.value = response;
//     loading.value = false;
//   }
//
//   getSingleRides(int rideID) async {
//     loading.value = true;
//     BaseRideResponse response = BaseRideResponse.fromMap(
//         (await repository.get2(ApiRoutes.getSingelRide(rideID))).data);
//     _ride.value = response;
//     loading.value = false;
//   }
//
//
//   changeRideReply(ChangeRideStatusRequest request) async{
//     SingleRideReply response = SingleRideReply.fromMap((await repository.post2(ApiRoutes.changeRideReplyStatus(), request.toJson())).data);
//     if (request.status == "accepted") {
//     _ride.value.data.ride.rideReply.clear();
//     _ride.value = _ride.value;
//     } else if (request.status == "rejected"||request.status == "canceled") {
//     _ride.value.data.ride.rideReply.removeWhere((element) => element.id == response.data.rideRequest.id);
//     _ride.value =  _ride.value;
//     } else {
//       return _ride.value.data.ride.rideReply.add(response.data.rideRequest);
//     }
//   }
//
//   Future<BaseRideResponse> makeRide(MakeRideRequest request) async {
//     BaseRideResponse response = BaseRideResponse.fromMap(
//         (await repository.post2(ApiRoutes.makeTaxiRequest(), request.toJson()))
//             .data);
//
//     print("ride -------------------------->> " +
//         response.data.ride.toJson().toString());
//     return _ride.value = response;
//   }
//
//   changeRideStatus(ChangeRideStatusRequest request) async {
//     BaseRideResponse response = BaseRideResponse.fromMap(
//         (await repository.post2(ApiRoutes.changeRideStatus(), request.toJson()))
//             .data);
//     if (request.status == "accepted") {
//       _ride.value.data.ride.rideReply.clear();
//       _ride.value =  _ride.value;
//     } else if (request.status == "canceled") {
//       _ride.value.data.ride.rideReply.clear();
//       _ride.value =  _ride.value;
//     } else {
//       return _ride.value = response;
//     }
//     //return _ride.value = response;
//   }
//
//   rateRideByUser(UserRateRequest request) async {
//     BaseRideResponse response = BaseRideResponse.fromMap(
//         (await repository.post2(ApiRoutes.rateRideByUser(), request.toJson()))
//             .data);
//     return _ride.value = response;
//   }
//
//   dispose() {
//     _vehickeTypes.close();
//   }
//
//   clear() {
//     _vehickeTypes = BehaviorSubject<VehicleTypeResponse>();
//     _ride = BehaviorSubject<BaseRideResponse>();
//   }
//
//   BehaviorSubject<VehicleTypeResponse> get vehickeTypes => _vehickeTypes;
//
//   BehaviorSubject<BaseRideResponse> get ride => _ride;
//
//   BehaviorSubject<UserRidesResponse> get rides => _rides;
//
//   BehaviorSubject<ShowRideReplyByRide> get rideReplyies => _rideReplies;
//
//   Event lastEvent;
//   String lastConnectionState;
//   Channel channel;
//   String appKey = "b55fc253e80a08f30c4c";
//   String channelRide = "ride";
//
//   String channelBaseRide = "ride.";
//   String channelBaseRideReply = "ridereply.";
//   String channelRideReply = "ride";
//
//   // ride events
//   String eventNewRide = "App\\Events\\NewRide";
//   String eventstatusRide = "App\\Events\\RideStatus";
//
//   // ride reply events
//   String eventNewRideReply = "App\\Events\\NewRideReply";
//   String eventstatusRideReply = "App\\Events\\RideReplyStatus";
//
//   String cluster = "eu";
//
//   bool encrypted = false;
//   bool logging = true;
//
//   Future<void> initPusher() async {
//     // try {
//     //   await Pusher.init(
//     //       appKey,
//     //       PusherOptions(
//     //         cluster: cluster,
//     //       ),
//     //       enableLogging: logging);
//     //
//     //   await connect();
//     // } on PlatformException catch (e) {
//     //   print("platform exeption ------------------->   ");
//     //   print(e.message);
//     // }
//   }
//
//   connect() {
//     // Pusher.connect(onConnectionStateChange: (x) async {
//     //   lastConnectionState = x.currentState;
//     //   debugPrint("in connection --->> >> ");
//     // }, onError: (x) {
//     //   debugPrint("Error in connection --->> >> : ${x.message}");
//     // });
//   }
//
//   disconnect() {
//     // Pusher.disconnect();
//   }
//
//   subscribeRideID(int rideID) async {
//     // channel = await Pusher.subscribe(channelBaseRide + rideID.toString());
//   }
//
//   subscribeRide() async {
//     // channel = await Pusher.subscribe(channelRide.toString());
//   }
//
//   subscribeRideReply(int rideReplyID) async {
//     // channel = await Pusher.subscribe(channelRideReply + rideReplyID.toString());
//   }
//
//   unsubscribeRideID(int rideID) async {
//     // await Pusher.unsubscribe(channelBaseRide + rideID.toString());
//   }
//
//   unsubscribeRide() async {
//     // await Pusher.unsubscribe(channelRide.toString());
//   }
//
//   unsubscribeRideReplyID(int rideReplyID) async {
//     // await Pusher.unsubscribe(channelRideReply + rideReplyID.toString());
//   }
//
//   bind() async {
//     await bindNewRideReply();
//     await bindRideStatus();
//   }
//
//   bindNewRide() async {
//     print("bindNewRide");
//     await channel.bind(this.eventNewRide, (x) {
//       lastEvent = x;
//     });
//   }
//
//   bindRideStatus() async {
//     print("bindNewRideStatus");
//     await channel.bind(this.eventstatusRide, (x) async {
//       lastEvent = x;
//       Ride ride = Ride.fromMap(json.decode(lastEvent.data));
//       if (ride.status == "start" || ride.status == "accepted") {
//         print('>>>>> ');
//         driverStateBloc.setState(19);
//         driverStateBloc.state.value = driverStateBloc.state.value;
//       } else if (ride.status == "end") {
//         print('>>>> trip ended');
//         _ride = BehaviorSubject<BaseRideResponse>();
//         driverStateBloc.setState(10);
//         driverStateBloc.state.value = driverStateBloc.state.value;
//         await unsubscribeRideID(ride.id);
//       } else {
//         _ride.value.data.ride = ride;
//         _ride.value = _ride.value;
//       }
//     });
//   }
//
//   bindNewRideReply() async {
//     await channel.bind(this.eventNewRideReply, (x) {
//       lastEvent = x;
//
//       print("bindNewRideReply");
//       Ride_replyBean ride = Ride_replyBean.fromList(json.decode(lastEvent.data));
//
//       _ride.value.data.ride.rideReply.add(ride);
//       _ride.value = _ride.value;
//     });
//   }
//
//   bindNewRideReplyStatus() async {
//     await channel.bind(this.eventstatusRideReply, (x) {
//       lastEvent = x;
//     });
//   }
//
//   unBindNewRide() async {
//     await channel.unbind(eventNewRide);
//   }
//
//   unBindNewRideStatus() async {
//     await channel.unbind(eventstatusRide);
//   }
//
//   unBindNewRideReply() async {
//     await channel.unbind(eventNewRideReply);
//   }
//
//   unBindNewRideReplyStatus() async {
//     await channel.unbind(eventstatusRideReply);
//   }
// }
//
// final taxiBloc = TaxiRideBloc();
