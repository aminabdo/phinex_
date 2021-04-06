import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/reservations/tech_reservations_model.dart';
import 'package:phinex/Bles/bloc/reservations/reservations_bloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class MyReservationsPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _MyReservationsPageState createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {

  @override
  void initState() {
    super.initState();

    reservationBloc.getTechReservations(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('reservations'),
        context,
        onBackBtnClicked: () {
            Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
        },
      ),
      body: WillPopScope(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(AppUtils.translate(context, 'professions'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
              StreamBuilder<TechReservationsModel>(
                stream: reservationBloc.techReservation.stream,
                builder: (context, snapshot) {
                  if(reservationBloc.techReservation.value.data != null) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime createdAt = DateTime.parse(snapshot.data.data[index].createdAt);
                        return Card(
                          margin: EdgeInsets.all(6),
                          elevation: 4,
                          child: Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage('assets/images/avatar.png'),
                                ),
                                title: Text(
                                  '${AppUtils.userData.firstName} ${AppUtils.userData.lastName}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                // trailing: Container(
                                //   width: ScreenUtil().setWidth(100),
                                //   padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                                //   decoration: BoxDecoration(
                                //     color: Color(0xffFDE4E5),
                                //     borderRadius: BorderRadius.circular(30),
                                //   ),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Icon(
                                //         Icons.cancel,
                                //         color: Colors.red,
                                //         size: 20,
                                //       ),
                                //       SizedBox(
                                //         width: ScreenUtil().setWidth(8),
                                //       ),
                                //       Text(
                                //         AppLocalization.of(context).translate('cancel'),
                                //         style: TextStyle(
                                //           color: Colors.red,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(35),
                                        height: ScreenUtil().setHeight(35),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: deepBlueColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            FontAwesomeIcons.solidClock,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Text(
                                        '${createdAt.year}/${createdAt.month}/${createdAt.day}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Text(
                                        '${createdAt.hour}:${createdAt.minute}:${createdAt.second}',
                                        style: TextStyle(color: Colors.grey, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: ScreenUtil().setWidth(35),
                                        height: ScreenUtil().setHeight(35),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: deepBlueColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            FontAwesomeIcons.stethoscope,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Text(
                                        AppUtils.translate(context, 'profession'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Text(
                                        snapshot.data.data[index].status.toString(),
                                        style: TextStyle(color: Colors.grey, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data.data?.length,
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.width / 3),
                        Loader(),
                        SizedBox(height: MediaQuery.of(context).size.width / 3),
                      ],
                    );
                  }
                }
              ),
            ],
          ),
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false).setPage(MorePage.pageIndex, MorePage());
          return false;
        },
      ),
    );
  }
}
