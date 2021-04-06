import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/order/OrdersResponse.dart';
import 'package:phinex/Bles/bloc/store/OrderBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/more/more_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'order_details_page.dart';

class MyOrdersPage extends StatefulWidget {
  static final int pageIndex = 4;

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  void initState() {
    super.initState();

    orderBloc.clear();
    orderBloc.getMyOrders(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('orders'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(
            MorePage.pageIndex,
            MorePage(),
          );
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MorePage.pageIndex, MorePage());
          return false;
        },
        child: StreamBuilder<OrdersResponse>(
          stream: orderBloc.myOrders.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data.data.isEmpty) {
                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/no_orders_found.svg'),
                      Text(AppUtils.translate(context, 'no_orders'))
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  physics: bouncingScrollPhysics,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(
                        ScreenUtil().setWidth(4),
                      ),
                      width: double.infinity,
                      color: Colors.white,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(
                            ScreenUtil().setWidth(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setHeight(140),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalization.of(context)
                                                .translate('order_placed_on'),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            AppLocalization.of(context)
                                                .translate('order_id'),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                          // Text(
                                          //   AppLocalization.of(context)
                                          //       .translate('recipient'),
                                          //   textAlign: TextAlign.left,
                                          //   style: TextStyle(
                                          //     color: Colors.grey,
                                          //     fontSize: 13,
                                          //   ),
                                          // ),
                                          Text(
                                            AppLocalization.of(context)
                                                .translate('payment_method'),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(15),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setHeight(140),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.data[index].createdAt
                                                .substring(0, 10),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data.data[index].id
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data.data[index].payment,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(15),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: ScreenUtil().setHeight(140),
                                      child: Center(
                                        child: Container(
                                          width: double.infinity,
                                          height: ScreenUtil().setHeight(90),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color:
                                                  mainColor.withOpacity(.3)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalization.of(context)
                                                    .translate('total'),
                                                style: TextStyle(
                                                  color: deepBlueColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    ScreenUtil().setHeight(5),
                                              ),
                                              Text(
                                                '${snapshot.data.data[index].total} ${AppUtils.currency}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              myButton(
                                AppLocalization.of(context)
                                    .translate('order_details'),
                                onTap: () {
                                  Provider.of<PageProvider>(context,
                                          listen: false)
                                      .setPage(
                                    OrderDetailsPage.pageIndex,
                                    OrderDetailsPage(
                                      orderId: snapshot.data.data[index].id,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.data.length,
                );
              }
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            return Loader();
          },
        ),
      ),
    );
  }
}
