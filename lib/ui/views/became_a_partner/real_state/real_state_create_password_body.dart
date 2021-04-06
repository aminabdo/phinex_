import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/bloc/real_state/RealState.dart';
import 'package:phinex/providers/real_estate_provider.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import '../done_page.dart';
import 'real_state_registeration_page.dart';

class RealStateCreatePasswordBody extends StatefulWidget {
  @override
  _RealStateCreatePasswordBodyState createState() =>
      _RealStateCreatePasswordBodyState();
}

class _RealStateCreatePasswordBodyState
    extends State<RealStateCreatePasswordBody> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';

  @override
  void initState() {
    super.initState();

    realStateBloc.create.onListen = getData();
  }

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
          translate(context, translate(context, 'finish')),
          onTap: () {
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
              RealStateRegiserationPage.realStateRequest.password =
                  passwordController.text;

              sendDoctorRegestirationRequest();
            }
          },
        ),
      ],
    );
  }

  void sendDoctorRegestirationRequest() {
    realEstateProvider.setIsLoading(true);
    RealStateRegiserationPage.realStateRequest.website = '';
    RealStateRegiserationPage.realStateRequest.addressLongitude = double.parse(LONGITUDE);
    RealStateRegiserationPage.realStateRequest.addressLatitude = double.parse(LATITUDE);
    realStateBloc.createRealState(RealStateRegiserationPage.realStateRequest);
  }

  void Function() getData() {
    realStateBloc.create.stream.listen(
      (value) {
        if (value == null) {
          realEstateProvider.setIsLoading(false);
          realEstateProvider.setCurrentIndicatorNumber(1);
          return;
        }
        if (value.statusCode >= 200 && value.statusCode < 300) {
          AppUtils.showToast(msg: translate(context, 'account_created_successfully'), bgColor: mainColor);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DonePage(),
            ),
          )
              .then(
            (value) {
              realStateBloc.clear();
              realStateBloc.create.value = null;
              value = null;
              realEstateProvider.setIsLoading(false);
              realEstateProvider.setCurrentIndicatorNumber(1);
            },
          );
        } else {
          print(value.data);
          AppUtils.showToast(msg: value.statusMessage);
          realEstateProvider.setIsLoading(false);
        }
      },
    );
  }
}
