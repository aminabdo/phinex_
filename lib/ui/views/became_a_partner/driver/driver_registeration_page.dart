import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:phinex/Bles/Model/requests/driver/DriverCreateRequest.dart';
import 'package:phinex/Bles/bloc/driver/DriverBloc.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import '../done_page.dart';
import 'driver_create_password_body.dart';
import 'driver_document_body.dart';
import 'driver_personal_data_body.dart';
import 'driver_vehicle_body.dart';

class DriverRegisterationPage extends StatefulWidget {
  static DriverCreateRequest driverRequest = DriverCreateRequest();

  @override
  DriverRegisterationPageState createState() => DriverRegisterationPageState();
}

class DriverRegisterationPageState extends State<DriverRegisterationPage> {

  @override
  void initState() {
    super.initState();

    driverBloc.getDriverCreateDetails();
  }

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: driverProvider.currentIndicatorNumber.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: myAppBar(
            AppLocalization.of(context).translate('driver'),
            context,
            onBackBtnClicked: () {
              if (driverProvider.currentIndicatorNumber.value == 1) {
                Navigator.pop(context);
              }
              else {
                driverProvider.setCurrentIndicatorNumber(driverProvider.currentIndicatorNumber.value - 1);
              }
            },
            actions: [
              driverProvider.currentIndicatorNumber.value == 1
                  ? SizedBox()
                  : FlatButton(
                      onPressed: () {
                        if (driverProvider.currentIndicatorNumber.value == 1) return;
                        driverProvider.setCurrentIndicatorNumber(driverProvider.currentIndicatorNumber.value - 1);
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
            isLoading: driverProvider.isLoading.value,
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
                      selectedStep: driverProvider.currentIndicatorNumber.value,
                      nbSteps: 4,
                      selectedStepColorOut: mainColor,
                      selectedStepColorIn: mainColor,
                      doneStepColor: mainColor,
                      doneLineColor: mainColor,
                      undoneLineColor: Colors.grey,
                      isHorizontal: true,
                      lineLength: ScreenUtil().setWidth(MediaQuery.of(context).size.width / 3.5 - 50),
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
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalization.of(context).translate('personal'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          AppLocalization.of(context).translate('documents'),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          AppLocalization.of(context).translate('vehicle_data'),
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
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    driverProvider.currentIndicatorNumber.value == 1
                        ? DriverPersonalDataBody()
                        : driverProvider.currentIndicatorNumber.value == 2
                            ? DriverDocumentBody()
                            : driverProvider.currentIndicatorNumber.value == 3
                                ? DriverVehicleBody()
                                : driverProvider.currentIndicatorNumber.value == 4
                                    ? DriverCreatePasswordBody()
                                    : DonePage(),
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
