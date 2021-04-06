import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:steps_indicator/steps_indicator.dart';
import 'package:phinex/Bles/Model/requests/froms/MerchantFormRequest.dart';
import 'package:phinex/Bles/bloc/store/StoreBloc.dart';
import 'package:phinex/providers/merchant_provider.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'merchant_create_password_body.dart';
import 'merchant_personal_data_body.dart';

class MerchantRegisterationPage extends StatefulWidget {
  static MerchantFormRequest merchantRequest = MerchantFormRequest();

  @override
  MerchantRegisterationPageState createState() =>
      MerchantRegisterationPageState();
}

class MerchantRegisterationPageState extends State<MerchantRegisterationPage> {
  
  @override
  void initState() {
    super.initState();

    storeBloc.getCreateDetails();
  }
  

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: merchantProvider.currentIndicatorNumber.stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: myAppBar(
            AppLocalization.of(context).translate('merchant'),
            context,
            onBackBtnClicked: () {
              if (snapshot.data == 1) {
                Navigator.pop(context);
                return;
              } else {
                merchantProvider.setCurrentIndicatorNumber((merchantProvider.currentIndicatorNumber.value - 1));
              }
            },
            actions: [
              snapshot.data == 1
                  ? SizedBox()
                  : FlatButton(
                      onPressed: () {
                        if (snapshot.data == 1) return;
                        merchantProvider.setCurrentIndicatorNumber((merchantProvider.currentIndicatorNumber.value - 1));
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
            isLoading: merchantProvider.isLoading.value,
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
                      selectedStep: merchantProvider.currentIndicatorNumber.value,
                      nbSteps: 2,
                      selectedStepColorOut: mainColor,
                      selectedStepColorIn: mainColor,
                      doneStepColor: mainColor,
                      doneLineColor: mainColor,
                      undoneLineColor: Colors.grey,
                      isHorizontal: true,
                      lineLength: ScreenUtil().setWidth(MediaQuery.of(context).size.width / 1.7),
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
                            AppLocalization.of(context).translate(
                                'personal \n${AppLocalization.of(context).translate('business')}'),
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
                    merchantProvider.currentIndicatorNumber.value == 1
                        ? MerchantPersonalDataBody()
                        : MerchantCreatePasswordBody(),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
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
