import 'package:flutter/material.dart';

import '../../../Bles/Model/responses/taxi_client/UserRidesResponse.dart';
import '../../../Bles/bloc/taxi/TaxiRideBloc.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/consts.dart';
import '../../widgets/app_from_to_drop_layout.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_loader.dart';
import 'single_trip_history_page.dart';

class AllTripsPage extends StatefulWidget {
  @override
  _AllTripsPageState createState() => _AllTripsPageState();
}

class _AllTripsPageState extends State<AllTripsPage> {
  @override
  void initState() {
    super.initState();

    taxiBloc.getUserRides(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(translate(context, 'my_trips'), context),
      body: StreamBuilder<UserRidesResponse>(
        stream: taxiBloc.rides.stream,
        builder: (context, snapshot) {
          if (taxiBloc.loading.value) {
            return Loader();
          }
          var allRides = snapshot.data.data.rides;
          return allRides.isEmpty ? SizedBox.shrink() : SingleChildScrollView(
            physics: bouncingScrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    AppUtils.translate(context, 'history'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SingleTripHistoryPage(
                                  tripId: allRides[index].id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    allRides[index].date??'',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        allRides[index].time??'',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        allRides[index].paymentMethod??'',
                                        style: TextStyle(color: mainColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              MyDropLayout(
                                from: allRides[index].startLocation,
                                to: allRides[index].endLocation,
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: allRides.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
