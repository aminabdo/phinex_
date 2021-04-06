import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/bloc/driver/DriverBloc.dart';
import 'package:phinex/providers/driver_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import '../done_page.dart';
import 'driver_registeration_page.dart';

class DriverCreatePasswordBody extends StatefulWidget {
  @override
  _DriverCreatePasswordBodyState createState() =>
      _DriverCreatePasswordBodyState();
}

class _DriverCreatePasswordBodyState extends State<DriverCreatePasswordBody> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';

  String translate(BuildContext context, String key) {
    return AppLocalization.of(context).translate(key);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFormField(
          obscureText: hidePassword,
          errorMessage: passwordErrorMessage,
          controller: passwordController,
          title: AppLocalization.of(context).translate('password'),
          suffixIcon: GestureDetector(
            onTap: () {
              hidePassword = !hidePassword;
              setState(() {});
            },
            child: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: hidePassword ? Colors.grey : mainColor,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        MyTextFormField(
          obscureText: hideConfirmPassword,
          errorMessage: confirmPasswordErrorMessage,
          title: AppLocalization.of(context).translate('confirm_password'),
          controller: confirmPasswordController,
          suffixIcon: GestureDetector(
            onTap: () {
              hideConfirmPassword = !hideConfirmPassword;
              setState(() {});
            },
            child: Icon(
              hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
              color: hideConfirmPassword ? Colors.grey : mainColor,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(25),
        ),
        myButton(
          translate(context, 'finish'),
          onTap: () async {
            // confirm password
            if (passwordController.text.isEmpty) {
              passwordErrorMessage =
                  AppLocalization.of(context).translate("required");
            } else if (passwordController.text.length < 8) {
              passwordErrorMessage = AppLocalization.of(context)
                  .translate('create_new_password_msg');
            } else {
              passwordErrorMessage = null;
            }

            // password
            if (confirmPasswordController.text.isEmpty) {
              confirmPasswordErrorMessage =
                  AppLocalization.of(context).translate("required");
            } else if (confirmPasswordController.text !=
                passwordController.text) {
              confirmPasswordErrorMessage = AppLocalization.of(context)
                  .translate("confirm_password_not_match");
            } else {
              confirmPasswordErrorMessage = null;
            }

            setState(() {});

            if (passwordErrorMessage == null &&
                confirmPasswordErrorMessage == null) {
              DriverRegisterationPage.driverRequest.password =
                  passwordController.text;

              sendRegisterationRequest();
            }
          },
        ),
      ],
    );
  }

  void sendRegisterationRequest() async {
    driverProvider.setIsLoading(true);
    DriverRegisterationPage.driverRequest.type = 'rental';
    var response = await driverBloc.createDriver(DriverRegisterationPage.driverRequest);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      AppUtils.showToast(msg: translate(context, 'account_created_successfully'), bgColor: mainColor);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => DonePage(),),)
          .then(
            (value) {
          driverBloc.clear();
          driverBloc.create.value = null;
          driverProvider.setIsLoading(false);
          driverProvider.setCurrentIndicatorNumber(1);
        },
      );
    } else {
      print(response.data);
      AppUtils.showToast(msg: response.data['message'][0].toString());
      driverProvider.setIsLoading(false);
    }
  }
}
