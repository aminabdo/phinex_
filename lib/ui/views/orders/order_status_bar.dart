import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';


class OrderStatus extends StatefulWidget {
  final int index;

  const OrderStatus({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return widget.index == 0
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getDoneContainer(),
                  getDoneDivider(),
                  getSemiConfirmedContainer(),
                  getFutureDivider(),
                  getFutureContainer(),
                  getFutureDivider(),
                  getFutureContainer(),
                  getFutureDivider(),
                  getFutureContainer(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        AppLocalization.of(context).translate('arrived_in'),
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : widget.index == 1
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getDoneContainer(),
                      getDoneDivider(),
                      getConfirmedContainer(),
                      getFutureDivider(),
                      getSemiPickedContainer(),
                      getFutureDivider(),
                      getFutureContainer(),
                      getFutureDivider(),
                      getFutureContainer(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(55),
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppLocalization.of(context)
                                  .translate('order_confirmed'),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              '',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalization.of(context).translate('arrived_in'),
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            : widget.index == 2
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          getDoneContainer(),
                          getDoneDivider(),
                          getDoneContainer(),
                          getDoneDivider(),
                          getPickedContainer(),
                          getFutureDivider(),
                          getSemiShippedContainer(),
                          getFutureDivider(),
                          getFutureContainer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: Localizations.localeOf(context)
                                          .languageCode ==
                                      'ar'
                                  ? ScreenUtil().setWidth(135)
                                  : 0,
                              left: Localizations.localeOf(context)
                                          .languageCode ==
                                      'en'
                                  ? ScreenUtil().setWidth(135)
                                  : 0,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalization.of(context)
                                      .translate('picked_by_courier'),
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : widget.index == 3
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getDoneContainer(),
                              getDoneDivider(),
                              getDoneContainer(),
                              getDoneDivider(),
                              getDoneContainer(),
                              getDoneDivider(),
                              getShippedContainer(),
                              getFutureDivider(),
                              getSemiArivedContainer(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? ScreenUtil().setWidth(200)
                                      : 0,
                                  left: Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? ScreenUtil().setWidth(0)
                                      : ScreenUtil().setWidth(208),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalization.of(context)
                                          .translate('shipped'),
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppLocalization.of(context)
                                        .translate('arrived_in'),
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : widget.index == 4
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  getDoneContainer(),
                                  getDoneDivider(),
                                  getDoneContainer(),
                                  getDoneDivider(),
                                  getDoneContainer(),
                                  getDoneDivider(),
                                  getDoneContainer(),
                                  getDoneDivider(),
                                  getArivedContainer(),
                                ],
                              ),
                              Align(
                                alignment: Localizations.localeOf(context)
                                            .languageCode ==
                                        'en'
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        AppLocalization.of(context)
                                            .translate('arrived'),
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox();
  }

  Widget getDoneDivider() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 2,
      width: MediaQuery.of(context).size.width / 8,
      color: mainColor,
    );
  }

  Widget getFutureDivider() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 2,
      width: MediaQuery.of(context).size.width / 8,
      color: Colors.grey,
    );
  }

  Widget getDoneContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainColor,
      ),
    );
  }

  Widget getFutureContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
    );
  }

  Widget getConfirmedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 5,
          color: mainColor,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: mainColor,
          size: 20,
        ),
      ),
    );
  }

  Widget getSemiConfirmedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 5,
          color: Colors.grey[300],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.grey,
          size: 20,
        ),
      ),
    );
  }

  Widget getPickedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainColor,
        border: Border.all(
          width: 2,
          color: mainColor,
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/order_picked_white.png'),
        ),
      ),
    );
  }

  Widget getSemiPickedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.grey[300],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/order_picked.png'),
        ),
      ),
    );
  }

  Widget getShippedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainColor,
        border: Border.all(
          width: 2,
          color: mainColor,
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/shipped_white.png'),
        ),
      ),
    );
  }

  Widget getSemiShippedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.grey[300],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/shipped.png'),
        ),
      ),
    );
  }

  Widget getArivedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: mainColor,
        border: Border.all(
          width: 2,
          color: mainColor,
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/arrived_white.png'),
        ),
      ),
    );
  }

  Widget getSemiArivedContainer() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.grey[300],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/arrived.png'),
        ),
      ),
    );
  }
}
