import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phinex/Bles/Model/responses/taxi_client/BaseRideResponse.dart';
import 'package:phinex/Bles/bloc/taxi/TaxiRideBloc.dart';
import 'package:phinex/ui/widgets/app_from_to_drop_layout.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import '../../../utils/consts.dart';

class SingleTripHistoryPage extends StatefulWidget {

  final int tripId;

  const SingleTripHistoryPage({Key key, @required this.tripId}) : super(key: key);

  @override
  _SingleTripHistoryPageState createState() => _SingleTripHistoryPageState();
}

class _SingleTripHistoryPageState extends State<SingleTripHistoryPage> {

  Completer<GoogleMapController> _controller = Completer();

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 18.4746,
  );

  @override
  void initState() {
    super.initState();

    print(widget.tripId);
    taxiBloc.getSingleRides(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar( translate(context, 'trip_history'), context),
      body: StreamBuilder<BaseRideResponse>(
        stream: taxiBloc.ride.stream,
        builder: (context, snapshot) {
          if(taxiBloc.loading.value) {
            return Loader();
          }

          else {
            var trip = snapshot.data.data.ride;
            _kGooglePlex = CameraPosition(
              target: LatLng(double.parse(trip.startLat?? '37.42796133580664'), double.parse(trip.endLat ?? '-122.085749655962')),
              zoom: 18.4746,
            );

            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(200),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            translate(context, 'trip_id'),
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          trailing: Text(
                            trip.id.toString(),
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            translate(context, 'trip_face'),
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            trip.paymentMethod??"",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          trailing: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${AppUtils.currency}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      trip.price.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: mainColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            width: ScreenUtil().setWidth(180),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trip.date.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              MyDropLayout(
                                from: trip.startLocation,
                                to: trip.endLocation,
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        ListTile(
                          title: Text(
                            translate(context, 'your_rate'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          trailing: RatingBar.builder(
                            initialRating: (double.tryParse(trip.driverRate))??0,
                            minRating: 0,
                            itemSize: 16,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                              horizontal: 0.0,
                            ),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: goldColor,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    width: double.infinity,
                    color: Color(0xffEEEEEE),
                    child: Text('Driver Info'),
                  ),
                  ListTile(
                    title: Text(
                      'user',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          trip.driverRate?.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star,
                          color: goldColor,
                          size: 20,
                        ),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          'car type',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'car number',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
