import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/bloc/medical_service/DoctorBloc.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import '../done_page.dart';
import 'doctor_registeration_page.dart';

class DoctorCreatePasswordBody extends StatefulWidget {
  @override
  _DoctorCreatePasswordBodyState createState() =>
      _DoctorCreatePasswordBodyState();
}

class _DoctorCreatePasswordBodyState extends State<DoctorCreatePasswordBody> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String passwordErrorMessage = '';
  String confirmPasswordErrorMessage = '';

  @override
  void initState() {
    super.initState();

    doctorBloc.create.onListen = getData();
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
          translate(context, 'finish'),
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
              DoctorRegisterationPage.doctorRequest.password =
                  passwordController.text;

              sendDoctorRegestirationRequest();
            }
          },
        ),
      ],
    );
  }

  void sendDoctorRegestirationRequest() {
    DoctorRegisterationPageState.isLoading = true;
    setState(() {});
    DoctorRegisterationPage.doctorRequest.hospitals[0].longitude = double.parse(LONGITUDE);
    DoctorRegisterationPage.doctorRequest.hospitals[0].latitude = double.parse(LATITUDE);
    print(DoctorRegisterationPage.doctorRequest.toJson());
    doctorBloc.createDoctor(DoctorRegisterationPage.doctorRequest);
    setState(() {});
  }

  void Function() getData() {
    doctorBloc.create.stream.listen(
      (value) {
        if (value == null) {
          DoctorRegisterationPageState.isLoading = (false);
          DoctorRegisterationPageState.currentIndicatorNumber = (1);
          setState(() {});
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
              doctorBloc.clear();
              doctorBloc.create.value = null;
              value = null;
              DoctorRegisterationPageState.isLoading = (false);
              DoctorRegisterationPageState.currentIndicatorNumber = (1);
              setState(() {});
            },
          );
        } else {
          print(value.data);
          AppUtils.showToast(msg: value.statusMessage);
          DoctorRegisterationPageState.isLoading = (false);
          setState(() {});
        }
      },
    );
  }
}
