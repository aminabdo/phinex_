import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/requests/social/UpdateUserProfile.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  final int userId;

  const ResetPasswordPage({Key key, @required this.userId}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String passwordWrongMessage;
  String confirmPasswordWrongMessage;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate("create_new_password"),
          context),
      body: LoadingOverlay(
        isLoading: isLoading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(12),
              vertical: ScreenUtil().setHeight(30),
            ),
            child: SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalization.of(context)
                        .translate("create_new_password"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    AppLocalization.of(context)
                        .translate("create_new_password_msg"),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  MyTextFormField(
                    title:
                        AppLocalization.of(context).translate("new_password"),
                    controller: passwordController,
                    errorMessage: passwordWrongMessage,
                    obscureText: hidePassword,
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
                    height: ScreenUtil().setHeight(20),
                  ),
                  MyTextFormField(
                    obscureText: hideConfirmPassword,
                    controller: confirmPasswordController,
                    errorMessage: confirmPasswordWrongMessage,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        hideConfirmPassword = !hideConfirmPassword;
                        setState(() {});
                      },
                      child: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: hideConfirmPassword ? Colors.grey : mainColor,
                      ),
                    ),
                    title: AppLocalization.of(context)
                        .translate("confirm_new_password"),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  myButton(
                    AppLocalization.of(context).translate("confirm"),
                    btnColor: mainColor,
                    onTap: () {
                      validateAndContinue();
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

  void validateAndContinue() async {
    AppUtils.hideKeyboard(context);

    // confirm password
    if (passwordController.text.isEmpty) {
      passwordWrongMessage = AppLocalization.of(context).translate("required");
    } else if (passwordController.text.length < 8) {
      passwordWrongMessage =
          AppLocalization.of(context).translate('create_new_password_msg');
    } else {
      passwordWrongMessage = null;
    }

    // password
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordWrongMessage =
          AppLocalization.of(context).translate("required");
    } else if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordWrongMessage =
          AppLocalization.of(context).translate("confirm_password_not_match");
    } else {
      confirmPasswordWrongMessage = null;
    }
    setState(() {});
    if (passwordWrongMessage == null && confirmPasswordWrongMessage == null) {
      isLoading = true;
      setState(() {});
      var response = await socialBloc.updateUserPassword(
        UpdateUserProfileRequest(
          password: passwordController.text,
          userId: widget.userId,
        ),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        AppUtils.showToast(
            msg: AppUtils.translate(context, 'done'), bgColor: mainColor);
        Navigator.of(context)
            .pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => LoginPage(),
          ),
          (_) => false,
        )
            .then((value) {
          isLoading = false;
          setState(() {});
        });
      } else {
        AppUtils.showToast(msg: response.data['message']);
        isLoading = false;
        setState(() {});
      }
    }
  }
}
