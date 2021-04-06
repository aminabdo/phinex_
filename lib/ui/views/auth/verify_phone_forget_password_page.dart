import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/store/single_product/UserBean.dart';
import 'package:phinex/Bles/bloc/auth/UserBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_pin_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'reset_password_page.dart';

class VerifyPhoneForgetPasswordPage extends StatefulWidget {
  final int userId;
  final String phone;

  const VerifyPhoneForgetPasswordPage({
    Key key,
    @required this.userId, @required this.phone,
  }) : super(key: key);

  @override
  _VerifyPhoneForgetPasswordPageState createState() =>
      _VerifyPhoneForgetPasswordPageState();
}

class _VerifyPhoneForgetPasswordPageState extends State<VerifyPhoneForgetPasswordPage> {
  String currentText;

  bool resendCode = false;
  bool isLoading = false;

  Timer timer;

  int value = 0;

  runTimer() {
    value = 0;
    setState(() {});
    timer = Timer.periodic(
      Duration(seconds: 1), (timer) {
        if (timer.tick == 60) {
          timer.cancel();
          resendCode = false;
          setState(() {});
        } else {
          value = timer.tick;
          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    authBloc.resendOtp(widget.userId);
  }

  @override
  void dispose() {
    if (timer != null) {
      if (timer.isActive) {
        timer.cancel();
      }
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate("verification"), context),
      body: LoadingOverlay(
        isLoading: isLoading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(12),
                vertical: ScreenUtil().setHeight(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalization.of(context)
                        .translate("verify_your_mobile_number"),
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    AppLocalization.of(context)
                        .translate("enter_the_6_digits_msg"),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(50),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(0),
                    ),
                    child: MyPinCodeTextField(
                      length: 6,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      shape: PinCodeFieldShape.box,
                      animationDuration: Duration(milliseconds: 300),
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                      animationCurve: Curves.easeInOut,
                      dialogTitle: 'Past Code',
                      backgroundColor: Colors.transparent,
                      inactiveColor: Colors.grey,
                      textInputType: TextInputType.number,
                      selectedColor: deepBlueColor,
                      activeColor: mainColor,
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(
                      MediaQuery.of(context).size.height * .35,
                    ),
                  ),
                  resendCode
                      ? Column(
                    children: [
                      LinearProgressIndicator(
                        value: (value * 1.67 / 100),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            deepBlueColor),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Center(
                        child: Text(
                          '${AppLocalization.of(context).translate("resend_code_after")} ${60 - value} ${AppLocalization.of(context).translate("sec")}',
                          style: TextStyle(color: deepBlueColor),
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          AppLocalization.of(context).translate("didn't_receive_code_?"),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(15),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            resendCode = true;
                            setState(() {});
                            runTimer();
                            authBloc.resendOtp(widget.userId);
                          },
                          child: Text(
                            AppLocalization.of(context)
                                .translate("resend"),
                            style: TextStyle(color: deepBlueColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(25),
                  ),
                  myButton(
                    AppLocalization.of(context).translate("verify"),
                    btnColor: mainColor,
                    onTap: () async {
                      isLoading = true;
                      setState(() {});
                      var response = await authBloc.verifyPhoneForgetPassword(currentText, widget.phone.toString());
                      AppUtils.userData = UserData();
                      AppUtils.userData.token = response.data['token'];
                      if (response.data['phone'] != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ResetPasswordPage(
                              userId: response.data['id'],
                            ),
                          ),
                        ).then((value) {
                          currentText = '';
                        });
                      } else {
                        AppUtils.showToast(msg: response.data['message']);
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
