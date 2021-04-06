import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/order/SinleOrderRespose.dart';
import 'package:phinex/Bles/bloc/store/OrderBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'my_orders_page.dart';
import 'order_status_bar.dart';

class OrderDetailsPage extends StatefulWidget {
  static final int pageIndex = 4;
  final int orderId;

  const OrderDetailsPage({Key key, @required this.orderId}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  // 0 > confirmed
  // 1 > start to picked
  // 2 > picked  &&  start to shipped
  // 3 > shipped  &&  start to arrived
  // 4 > arrived
  int state = 0;

  @override
  void initState() {
    super.initState();

    orderBloc.getSingleOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        AppLocalization.of(context).translate('order_details'),
        context,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MyOrdersPage.pageIndex, MyOrdersPage());
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(MyOrdersPage.pageIndex, MyOrdersPage());
          return false;
        },
        child: StreamBuilder<SinleOrderRespose>(
          stream: orderBloc.singleOrder.stream,
          builder: (context, snapshot) {
            if (orderBloc.loading.value) {
              return Loader();
            } else {
              state = snapshot.data.data.status == 'confirmed'
                  ? 1
                  : snapshot.data.data.status == 'processing'
                      ? 2
                      : snapshot.data.data.status == 'shipped'
                          ? 3
                          : 4;
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context)
                                .translate('order_placed_on'),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.data.data.createdAt.substring(0, 10),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context).translate('order_id'),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.data.data.id.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context).translate('recipient'),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            AppUtils.userData.username,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context)
                                .translate('payment_method'),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            snapshot.data.data.payment,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalization.of(context).translate('total')}: ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${snapshot.data.data.total} ${AppUtils.currency}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Container(
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalization.of(context)
                                    .translate('shippment_status'),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalization.of(context)
                                            .translate('date')
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.data.createdAt
                                            .substring(0, 10)
                                            .toUpperCase(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        AppLocalization.of(context)
                                            .translate('order_no')
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.data.id
                                            .toString()
                                            .toUpperCase(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                              OrderStatus(
                                index: state,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: Text(
                        AppLocalization.of(context)
                            .translate('products_details'),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(12)),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.orderItems.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data.data.orderItems[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(4),
                            ),
                            width: double.infinity,
                            height: ScreenUtil().setHeight(150),
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setWidth(12),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          item.image == null || item.image == ''
                                              ? Image.asset(
                                                  'assets/images/no-product-image.png',
                                                  fit: BoxFit.fill,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: item.image,
                                                ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            item.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${AppLocalization.of(context).translate('seller')}: ${item.vendorName}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${item.price}  ${Localizations.localeOf(context).languageCode == 'ar' ? AppLocalization.of(context).translate('egy') : AppLocalization.of(context).translate('dollar')}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                            ),
                                          ),
                                          Text(
                                            '${AppLocalization.of(context).translate('quantity')}: ${item.quantity}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      flex: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalization.of(context).translate('cancel_order'),
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
