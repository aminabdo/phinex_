
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:phinex/Bles/Model/requests/order/CheckoutRequest.dart';
import 'package:phinex/Bles/Model/responses/order/CheckoutResponse.dart';
import 'package:phinex/Bles/bloc/store/OrderBloc.dart';
import 'package:phinex/providers/checkout_provider.dart';
import 'package:phinex/ui/views/checkout/checkout_pointer.dart';
import 'package:phinex/ui/views/orders/done_order_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'first_page.dart';
import 'second_page.dart';
import 'third_page.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;

  const CheckoutPage({Key key, @required this.totalPrice}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: checkoutProvider.currentIndicatorNumber.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: myAppBar(
            AppLocalization.of(context).translate('checkout'),
            context,
            withLeading: true,
            actions: [
              FlatButton(
                onPressed: snapshot.data == 1
                    ? null
                    : () {
                        checkoutProvider.setCurrentIndicatorNumber(checkoutProvider.currentIndicatorNumber.value - 1);
                        setState(() {});
                      },
                child: Text(
                  snapshot.data == 1 ? '' : '${translate(context, 'previous')}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: ScreenUtil().setHeight(90),
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                  vertical: ScreenUtil().setHeight(5),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalization.of(context).translate('total'),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${AppUtils.currency} ${widget.totalPrice}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(30),
                    ),
                    Expanded(
                      child: myButton(
                        snapshot.data == 3 ? AppLocalization.of(context).translate('finish') : AppLocalization.of(context).translate('next'),
                        btnColor: mainColor,
                        onTap: () async {
                          if (snapshot.data == 1) {
                            checkoutProvider.setCurrentIndicatorNumber(2);
                          } else if (snapshot.data == 2) {
                            if(CheckoutPointer.address == null || CheckoutPointer.address.isEmpty) {
                              AppUtils.showToast(msg: AppUtils.translate(context, 'enter_address'));
                              return;
                            }
                            checkoutProvider.setCurrentIndicatorNumber(3);
                          } else {
                            checkoutProvider.setIsLoading(true);
                            CheckoutResponse response = await orderBloc.checkoutOrder(
                              CheckoutRequest()
                                ..userId = AppUtils.userData.id
                                ..address = CheckoutPointer.address
                                ..anotherShippingAddress = ''
                                ..city = 1
                                ..country = int.parse(AppUtils.getCountryId())
                                ..governorate = 1,
                            );

                            checkoutProvider.setIsLoading(false);

                            if (response.code >= 200 && response.code < 300) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DoneOrderPage(),
                                ),
                              ).then((value)  {
                                checkoutProvider.setCurrentIndicatorNumber(1);
                              });
                            } else {
                              AppUtils.showToast(msg: response.message);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: LoadingOverlay(
            progressIndicator: Loader(),
            color: Colors.white,
            isLoading: checkoutProvider.isLoading.value,
            opacity: .5,
            child: SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    StepsIndicator(
                      selectedStep: snapshot.data ?? 1,
                      nbSteps: 3,
                      selectedStepColorOut: mainColor,
                      selectedStepColorIn: mainColor,
                      doneStepColor: mainColor,
                      doneLineColor: mainColor,
                      undoneLineColor: Colors.grey,
                      isHorizontal: true,
                      lineLength: ScreenUtil().setWidth(MediaQuery.of(context).size.width / 3 - 18),
                      doneStepSize: 10,
                      unselectedStepSize: 10,
                      selectedStepSize: 14,
                      selectedStepBorderSize: 1,
                      doneStepWidget: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: mainColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: ScreenUtil().setWidth(15),
                            height: ScreenUtil().setHeight(15),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainColor,
                              border: Border.all(
                                color: mainColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Custom Widget
                      unselectedStepWidget: Container(
                        width: ScreenUtil().setWidth(30),
                        height: ScreenUtil().setHeight(30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                      // Custom Widget
                      selectedStepWidget: Container(
                        width: ScreenUtil().setWidth(30),
                        height: ScreenUtil().setHeight(30),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context).translate('delivery'),
                        ),
                        Text(
                          AppLocalization.of(context).translate('address'),
                        ),
                        Text(
                          AppLocalization.of(context).translate('payments'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    snapshot.data == 1
                        ? StepOne()
                        : snapshot.data == 2
                            ? StepTwo()
                            : StepThree(),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
