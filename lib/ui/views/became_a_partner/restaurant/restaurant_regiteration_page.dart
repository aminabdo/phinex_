import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:phinex/Bles/Model/requests/restaurant/RestaurantCreateRequest.dart';
import 'package:phinex/providers/resturant_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'restaurant_business_body.dart';
import 'restaurant_create_password_body.dart';
import 'restaurnat_personal_data_body.dart';

class RestaurantRegisterationPage extends StatefulWidget {

  static RestaurantCreateRequest restaurantRequest = RestaurantCreateRequest();

  @override
  RestaurantRegisterationPageState createState() => RestaurantRegisterationPageState();
}

class RestaurantRegisterationPageState extends State<RestaurantRegisterationPage> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: resturantProvider.currentIndicatorNumber.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: myAppBar(
            translate(context, 'restaurant'),
            context,
            onBackBtnClicked: () {
              if (snapshot.data == 1) {
                Navigator.pop(context);
              } else {
                resturantProvider.setCurrentIndicatorNumber(resturantProvider.currentIndicatorNumber.value - 1);
                setState(() {});
              }
            },
            actions: [
              snapshot.data == 1
                  ? SizedBox()
                  : FlatButton(
                      onPressed: () {
                        if (snapshot.data == 1) return;
                        resturantProvider.setCurrentIndicatorNumber(resturantProvider.currentIndicatorNumber.value - 1);
                        setState(() {});
                      },
                      child: Text(
                        translate(context, 'previous'),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
            ],
          ),
          body: LoadingOverlay(
            isLoading: resturantProvider.isLoading.value,
            opacity: .5,
            progressIndicator: Loader(),
            color: Colors.white,
            child: SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12),
                  vertical: ScreenUtil().setHeight(8),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    StepsIndicator(
                      selectedStep: snapshot.data,
                      nbSteps: 3,
                      selectedStepColorOut: mainColor,
                      selectedStepColorIn: mainColor,
                      doneStepColor: mainColor,
                      doneLineColor: mainColor,
                      undoneLineColor: Colors.grey,
                      isHorizontal: true,
                      lineLength: ScreenUtil()
                          .setWidth(MediaQuery.of(context).size.width / 2.5 - 50),
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
                      height: ScreenUtil().setHeight(5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalization.of(context).translate('personal'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            AppLocalization.of(context).translate('business'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            AppLocalization.of(context).translate('complete'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    snapshot.data == 1
                        ? RestaurantPersonalDataBody()
                        : snapshot.data == 2
                            ? RestaurantBussinesBody()
                            : RestaurantCreatePasswordBody(),
                    SizedBox(
                      width: ScreenUtil().setWidth(30),
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
